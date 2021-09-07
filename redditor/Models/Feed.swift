//
//  Model.swift
//  redditor
//
//  Created by Miguel Fraire on 9/4/21.
//
//   let feed = try? newJSONDecoder().decode(Feed.self, from: jsonData)

import Foundation

// MARK: - Feed
struct Feed: Decodable {
    let data: FeedData
}

// MARK: - FeedData
struct FeedData: Decodable {
    let after: String
    let children: [Child]
}

// MARK: - Child
struct Child: Decodable {
    let data: ChildData
}

// MARK: - ChildData
struct ChildData: Decodable{
    let title, url: String
    let thumbnail: String?
    let thumbnailHeight, thumbnailWidth: Int?
    let score, numComments: Int
    let isVideo: Bool
}
