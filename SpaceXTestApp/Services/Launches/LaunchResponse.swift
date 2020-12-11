//
//  LaunchResponse.swift
//  SpaceXTestApp
//
//  Created by vladikkk on 10/12/2020.
//

import Foundation

// MARK: - LaunchDataResponse
struct LaunchDataResponse: Decodable {
    let name: String
    let date: Int
    let links: LinkData
    
    let desc: String?
    let rocketName: String
    let payloads: [String]
        
    enum CodingKeys: String, CodingKey {
        case name
        case date = "date_unix"
        case links
        case desc = "details"
        case rocketName = "rocket"
        case payloads
    }
}

// MARK: - LinkData
struct LinkData: Decodable {
    let patch: PatchData
    let reddit: RedditData
    let flickr: FlickrData
    let youtubeId: String?
    let wikipediaLink: String?
        
    enum CodingKeys: String, CodingKey {
        case patch
        case reddit
        case flickr
        case youtubeId = "youtube_id"
        case wikipediaLink = "wikipedia"
    }
}

// MARK: - PatchData
struct PatchData: Codable {
    let small: String?
    let large: String?
    
    enum CodingKeys: String, CodingKey {
        case small
        case large
    }
}

// MARK: - RedditData
struct RedditData: Codable {
    let campaign: String?
    let launch: String?
    let media: String?
    let recovery: String?
}

// MARK: - FlickrData
struct FlickrData: Codable {
    let small: [String]
    let original: [String]
    
    enum CodingKeys: String, CodingKey {
        case small
        case original
    }
}
