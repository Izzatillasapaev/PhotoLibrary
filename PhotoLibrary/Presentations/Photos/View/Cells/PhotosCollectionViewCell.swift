//
//  PhotosCollectionViewCell.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 22.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var backImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthConstraint: NSLayoutConstraint!
    
    func configure(photo: Photo, size: CGSize) {
        let strokeTextAttributes = [
         .strokeColor : UIColor.black,
          .foregroundColor : UIColor.white,
          .strokeWidth : -1.0,
          .font : UIFont.boldSystemFont(ofSize: 23)]
          as [NSAttributedString.Key : Any]

        nameLabel.attributedText = NSMutableAttributedString(string: photo.filename, attributes: strokeTextAttributes)
        
        backImageView.imageFromServerURL(photo.baseUrl)
        widthConstraint.constant = size.width - 10
        heightConstraint.constant = size.height - 10
        
    }
}
