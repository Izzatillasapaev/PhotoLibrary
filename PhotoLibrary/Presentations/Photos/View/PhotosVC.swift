//
//  PhotosVC.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 22.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class PhotosVC: UIViewController, PhotosViewModelDelegate {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos: [Photo] = []
    var albumId: String?
    var viewModel: PhotosViewModel!
    
//    init(albumId: String) {
//        viewModel = PhotosViewModel(albumId: albumId)
//        super.init(nibName: nil, bundle: nil)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if albumId == nil {
             fatalError("albumId has not been implemented")
        }
        viewModel = PhotosViewModel(albumId: albumId!)
        viewModel.delegate = self
        viewModel.getPhotos()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    // on rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.collectionView.reloadData()
    }
    
    func getSizeForCell() -> CGSize {
        let screenSize =  UIScreen.main.bounds
        if screenSize.width < screenSize.height {
            return CGSize(width: UIScreen.main.bounds.width, height: 500)
        }
        return CGSize(width: UIScreen.main.bounds.width / 2 - 50, height: 500)
        
    }
    
    //MARK: Delegates
    func dataLoaded(photos: [Photo]) {
        self.photos = photos
        print(111, photos.count)
        self.collectionView.reloadData()
    }
    
    func additionalDataLoaded(photos: [Photo]) {
        self.photos += photos
        self.collectionView.reloadData()
    }
    
    func isLoading(loading: Bool) {
        loading ? self.showSpinner(onView: self.view) : self.removeSpinner()
    }
    
    func showError(error: String) {
        self.showAlert(title: "Ошибка", messageBody: error)    }
}

extension PhotosVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        
        cell.configure(photo: photos[indexPath.row], size: self.getSizeForCell())
        
        return cell
        
    }
    
}
extension PhotosVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if photos.count - indexPath.row <= 2 {
            self.viewModel.loadNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoViewerVC().fromSB()
        vc.photos = photos
        vc.indexPath = indexPath
//        vc.photos = self.photos
//        self.navigationController?.pushViewController(vc, animated: false)
        self.presentFullScreen(vc: vc)
    }
}

extension PhotosVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.getSizeForCell()
    }
}
