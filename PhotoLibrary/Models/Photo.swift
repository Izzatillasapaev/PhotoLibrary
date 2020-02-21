//
//  AlbumMedia.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 22.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

struct PhotoApiResponse: Codable {
    let photos: [Photo]
    let nextPageToken: String?
    
    enum CodingKeys: String, CodingKey {
        case nextPageToken
        case photos = "mediaItems"
    }
}
struct Photo: Codable {
    let id: String
    let baseUrl: String
    let mimeType: String
    let filename: String
    let mediaMetadata: PhotoData?
    
    func getCreatedDate() -> Date? {
        if mediaMetadata == nil || mediaMetadata?.creationTime == nil {
            return nil
        }
        return mediaMetadata!.creationTime!.toDate(format: "yyyy-MM-dd'T'HH:mm:ss'Z'")
    }
}
struct PhotoData: Codable {
    let creationTime: String?
}
