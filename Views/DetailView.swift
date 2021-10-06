//
//  DetailView.swift
//  YARUSTest2
//
//  Created by Михаил Кулагин on 06.10.2021.
//

import SwiftUI

struct DetailView: View {
    
    let photo: Photo
        
    var body: some View {
        ScrollView {
            VStack {
                //Photo
                AsyncImage(url: URL(string: photo.urls.small))
                
                //Photo Meta
                HStack {
                    Image(systemName: "heart.fill").foregroundColor(Color.red)
                    Text("\(photo.likes)")
                        .fontWeight(.semibold)
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "eye")
                    Text("\(photo.views)")
                        .fontWeight(.semibold)
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.down.to.line.alt")
                    Text("\(photo.downloads)")
                        .fontWeight(.semibold)
                        .font(.headline)
                }
                .padding()
                
                //User meta
                HStack(spacing: 20) {
                    AsyncImage(url: URL(string: (photo.user?.profile_image?.medium ?? "")))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(photo.user?.name ?? "")
                            .fontWeight(.semibold)
                            .font(.headline)
                        Text(photo.user?.twitter_username ?? "")
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    followButton()
                        .padding(.trailing)
                }
                .padding(.leading)
                .padding(.top)
            }
        }
    }
    
    func followButton() -> some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 3)
                .frame(width: 90, height: 40)
                .background(Color.white)
            Button {
                
            } label: {
                Text("Follow")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
    }
    
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
