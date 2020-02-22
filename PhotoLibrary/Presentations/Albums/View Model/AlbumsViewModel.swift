//
//  AlbumsViewModel.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 10.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

protocol AlbumsViewModelDelegate: class {
    func isLoading(loading: Bool)
    func showError(message: String)
    func dataLoaded(albums: [Album])
    func additionalDataLoaded(albums: [Album])
}
class AlbumsViewModel {
    weak var delegate: AlbumsViewModelDelegate?
    
    var networkManager = NetworkManager()
    var nextPageToken: String? = nil
    
    func getAlbums() {
        //        print("e311")
        self.delegate?.isLoading(loading: true)
        networkManager.getAlbums(nextPageToken: nextPageToken) { albumResponse, error in
            //            print("e3113")
            
            self.delegate?.isLoading(loading: false)
            if let error = error {
                self.delegate?.showError(message: error)
            }
            if let albumResponse = albumResponse {
                DispatchQueue.main.async {
                    let albums = albumResponse.albums.filter {
                        $0.mediaItemsCount != nil
                    }
                    if self.nextPageToken == nil {
                        
                        
                        self.delegate?.dataLoaded(albums: albums)
                    }
                    else {
                        
                        self.delegate?.additionalDataLoaded(albums: albums)
                    }
                    self.nextPageToken = albumResponse.nextPageToken
                }
            }
        }
    }
    
    func loadNextPage() {
        if nextPageToken == nil {
            return
        }
        getAlbums()
    }
}
