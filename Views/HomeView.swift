//
//  ContentView.swift
//  YARUSTest2
//
//  Created by Михаил Кулагин on 06.10.2021.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var pvm = PhotoViewModel()
    
    @State var makeHeartRed: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(pvm.photoList) { photo in
                    //User photo and name
                    HStack(spacing: 20) {
                        AsyncImage(url: URL(string: (photo.user?.profile_image?.medium ?? "")))
                            .clipShape(Circle())
                        Text(photo.user?.name ?? "")
                            .fontWeight(.semibold)
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.top, 30)
                    
                    //Photo
                    NavigationLink {
                        DetailView(photo: photo)
                    } label: {
                        AsyncImage(url: URL(string: photo.urls.small),
                                   content: { photo in photo },
                                   placeholder: { ProgressView() })
                    }
                    
                    //Buttons
                    HStack(spacing: 20) {
                        interactiveHeartButton()
                            .foregroundColor(makeHeartRed ? Color.red : .black)
                        interactiveButton(image: "plus.circle")
                        Spacer()
                        interactiveButton(image: "arrow.down")
                    }
                    .padding()
                }
            }
        }
        .navigationBarItems(trailing: Button("refresh") {
            pvm.getPhoto(countOfPhotos: 30)
        })
    }
    
    func interactiveButton(image: String) -> some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 3)
                .frame(width: 40, height: 40)
                .background(Color.white)
            Button {
                
            } label: {
                Image(systemName: image)
                    .accentColor(.black)
            }
        }
    }
    
    func interactiveHeartButton() -> some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 3)
                .frame(width: 40, height: 40)
                .background(Color.white)
            Button {
                makeHeartRed.toggle()
            } label: {
                Image(systemName: "heart")
                    .accentColor(.black)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
