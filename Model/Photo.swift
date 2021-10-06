//
//  Photo.swift
//  YARUSTest2
//
//  Created by Михаил Кулагин on 06.10.2021.
//

import Foundation

struct Photo: Decodable, Identifiable {
    let id: String
    let urls: Urls
    let likes: Int
    let user: User?
    let views: Int
    let downloads: Int
}

struct Urls: Decodable {
    let small: String
}

struct User: Decodable {
    let name: String
    let twitter_username: String?
    let profile_image: ProfileImage?
}

struct ProfileImage: Decodable {
    let medium: String
}
