//
//  AlbumsVC.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 10.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class AlbumsVC: UIViewController, AlbumsViewModelDelegate {
 
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var albums: [Album] = []


    var viewModel = AlbumsViewModel()


    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(113)
//        self.isLoading(loading: true)
        viewModel.delegate = self
        viewModel.getAlbums()
    }
    
    
    //MARK: View Model Delegate
    func dataLoaded(albums: [Album]) {
        self.albums = albums
        self.collectionView.reloadData()
    }


    
     func isLoading(loading: Bool) {
        loading ? self.showSpinner(onView: self.view) : self.removeSpinner()
    }
    
    func showError(error: String) {
        self.showAlert(title: "Ошибка", messageBody: error)    }
}
extension AlbumsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
        
        cell.configure(album: albums[indexPath.row])
        
        return cell
        
    }
    
    
}
extension AlbumsVC: UICollectionViewDelegate {
    
}
