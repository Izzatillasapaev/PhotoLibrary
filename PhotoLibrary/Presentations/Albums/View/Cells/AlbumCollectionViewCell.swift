//
//  AlbumCollectionViewCell.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 10.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var backImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    func configure(album: Album, size: CGSize) {
        let strokeTextAttributes = [
          NSAttributedString.Key.strokeColor : UIColor.black,
          NSAttributedString.Key.foregroundColor : UIColor.white,
          NSAttributedString.Key.strokeWidth : -1.0,
          NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 23)]
          as [NSAttributedString.Key : Any]

        titleLabel.attributedText = NSMutableAttributedString(string: album.title, attributes: strokeTextAttributes)
//        titleLabel.text = album.title
    
        backImageView.imageFromServerURL(album.coverPhotoBaseUrl)
        widthConstraint.constant = size.width - 10
        heightConstraint.constant = size.height - 10
        
    }
    
}
