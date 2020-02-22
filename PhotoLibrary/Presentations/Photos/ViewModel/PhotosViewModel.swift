//
//  PhotosViewModel.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 22.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

protocol PhotosViewModelDelegate: class {
    func isLoading(loading: Bool)
    func showError(message: String)
    func dataLoaded(photos: [Photo])
    func additionalDataLoaded(photos: [Photo])
}

final class PhotosViewModel {
    weak var delegate: PhotosViewModelDelegate?
    var networkManager = NetworkManager()
    var nextPageToken: String? = nil
    var albumId: String
    
    init(albumId: String) {
        self.albumId = albumId
    }
    
    func getPhotos() {
        //        print("e311")
        self.delegate?.isLoading(loading: true)
        networkManager.getPhotos(nextPageToken: nextPageToken, albumId: albumId) { photosResponse, error in
            
            self.delegate?.isLoading(loading: false)
            if let error = error {
                self.delegate?.showError(message: error)
            }
            if let photosResponse = photosResponse {
                DispatchQueue.main.async {
                    let photos = photosResponse.photos.filter {
                        $0.mimeType.contains(find: "image")
                    }
                    if self.nextPageToken == nil {
                        self.delegate?.dataLoaded(photos: photos )
                    }
                    else {
                        self.delegate?.additionalDataLoaded(photos: photos)
                    }
                    self.nextPageToken = photosResponse.nextPageToken
                }
            }
        }
    }
    
    func loadNextPage() {
        if nextPageToken == nil {
            return
        }
        getPhotos()
    }
    
}
