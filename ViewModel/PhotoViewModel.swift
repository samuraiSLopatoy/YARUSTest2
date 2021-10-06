//
//  PhotoViewModel.swift
//  YARUSTest2
//
//  Created by Михаил Кулагин on 06.10.2021.
//

import Foundation
import Combine

class PhotoViewModel: ObservableObject {
    
    @Published var photoList = [Photo]()
    
    init() {
        getPhoto(countOfPhotos: 30)
    }
    
    //MARK: - NETWORKING with COMBINE
    
    var cancellables = Set<AnyCancellable>()
    
    func getPhoto(countOfPhotos: Int) {
        
        let baseUrlString = "https://api.unsplash.com/photos/random?count=\(countOfPhotos)"
        let accessKey = "_KGMxQ1tx0LXKK4eVbuExCie2KQ1beW4nbfUWfU27kA"
        
        guard let urlString = URL(string: "\(baseUrlString)&client_id=\(accessKey)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: urlString)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: print("Working!")
                case .failure(let error): print("error. \(error)")
                }
            }, receiveValue: { jsonPhotos in
                self.photoList = jsonPhotos
            })
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
        return output.data
    }
    
}
