//
//  PhotoViewerVC.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 22.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

final class PhotoViewerVC: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var photos: [Photo] = []
    var indexPath: IndexPath!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
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
        let onShare: (_ url: String, _ image: UIImage, _ text: String) -> () = { url, image, text  in
            let share = [url]
                   let activityViewController = UIActivityViewController(activityItems: share, applicationActivities: nil)
                   activityViewController.popoverPresentationController?.sourceView = self.view
                   self.present(activityViewController, animated: true, completion: nil)
        }
        
        
        cell.configure(photo: photos[indexPath.row], onShare: onShare, size: CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height))
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

