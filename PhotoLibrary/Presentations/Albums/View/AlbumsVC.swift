//
//  AlbumsVC.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 10.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import GoogleSignIn


final class AlbumsVC: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    var albums: [Album] = []
    var viewModel = AlbumsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.getAlbums()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // on rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.collectionView.reloadData()
    }
    
    
    @IBAction func signOutPressed(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
        self.presentFullScreen(vc: AuthViewController().fromSB())
        
    }
    
    func getSizeForCell() -> CGSize {
        let screenSize =  UIScreen.main.bounds
        if screenSize.width < screenSize.height {
            return CGSize(width: UIScreen.main.bounds.width, height: 300)
        }
        return CGSize(width: UIScreen.main.bounds.width / 2 - 50, height: 300)
        
    }
    
}

extension AlbumsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
        
        cell.configure(album: albums[indexPath.row], size: self.getSizeForCell())
        
        return cell
        
    }
    
}
extension AlbumsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if albums.count - indexPath.row <= 2 {
            self.viewModel.loadNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotosVC().fromSB()
        vc.albumId = albums[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AlbumsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.getSizeForCell()
    }
}

extension AlbumsVC: AlbumsViewModelDelegate {
    
    //MARK: Delegates
    func dataLoaded(albums: [Album]) {
        self.albums = albums
        self.collectionView.reloadData()
    }
    
    func additionalDataLoaded(albums: [Album]) {
        self.albums += albums
        self.collectionView.reloadData()
    }
    
    func isLoading(loading: Bool) {
        loading ? self.showSpinner(onView: self.view) : self.removeSpinner()
    }
    
    func showError(error: String) {
        self.showAlert(title: "Ошибка", messageBody: error)
    }
}
