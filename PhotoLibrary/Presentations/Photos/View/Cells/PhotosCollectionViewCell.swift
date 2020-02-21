//
//  PhotosCollectionViewCell.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 22.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    func configure(photo: Photo, size: CGSize) {
        let strokeTextAttributes = [
          NSAttributedString.Key.strokeColor : UIColor.black,
          NSAttributedString.Key.foregroundColor : UIColor.white,
          NSAttributedString.Key.strokeWidth : -1.0,
          NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 23)]
          as [NSAttributedString.Key : Any]

        nameLabel.attributedText = NSMutableAttributedString(string: photo.filename, attributes: strokeTextAttributes)
//        nameLabel.text = photo.filename
    
        backImageView.imageFromServerURL(photo.baseUrl)
        widthConstraint.constant = size.width - 10
        heightConstraint.constant = size.height - 10
        
    }
}
