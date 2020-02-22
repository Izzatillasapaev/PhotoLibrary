//
//  PhotoViewerVC.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 22.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class PhotoViewerVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos: [Photo] = []
    var indexPath: IndexPath!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func dismissPressed(_ sender: Any) {
        self.dismissSelf()
    }

}

extension PhotoViewerVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoViewerCollectionViewCell
        cell.configure(photo: photos[indexPath.row], onShare: {_ in }, size: CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height))
        return cell
    }
    
    
}
extension PhotoViewerVC: UICollectionViewDelegate {
    
}
extension PhotoViewerVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
       }
}
