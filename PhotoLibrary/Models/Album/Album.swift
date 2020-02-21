//
//  Album.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 03.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

struct AlbumApiResponse: Codable {
    let albums: [Album]
    let nextPageToken: String?
}
struct Album: Codable {
    let id: String
    let title: String
    let productUrl: String
    let mediaItemsCount: String?
    let coverPhotoBaseUrl: String
    let coverPhotoMediaItemId: String?
}
