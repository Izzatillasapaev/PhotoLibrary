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
}
class AlbumsViewModel {
    weak var delegate: AlbumsViewModelDelegate?
    
    var networkManager = NetworkManager()
    
    
    func getAlbums(nextPageToken: String? = nil) {
        //        print("e311")
        self.delegate?.isLoading(loading: true)
        networkManager.getAlbums(nextPageToken: nextPageToken) { albums, error in
            print("e3113")
            
            self.delegate?.isLoading(loading: false)
            if let error = error {
                self.delegate?.showError(message: error)
            }
            if let albums = albums {
                DispatchQueue.main.async {
                }
            }
        }
        
    }
}
