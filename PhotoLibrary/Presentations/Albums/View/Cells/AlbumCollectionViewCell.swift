//
//  AlbumCollectionViewCell.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 10.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

final class AlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var backImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    
    func configure(album: Album, size: CGSize) {
        let strokeTextAttributes = [
          .strokeColor : UIColor.black,
          .foregroundColor : UIColor.white,
          .strokeWidth : -1.0,
          .font : UIFont.boldSystemFont(ofSize: 23)]
          as [NSAttributedString.Key : Any]

        titleLabel.attributedText = NSMutableAttributedString(string: album.title, attributes: strokeTextAttributes)
    backImageView.imageFromServerURL(album.coverPhotoBaseUrl)
        widthConstraint.constant = size.width - 10
        heightConstraint.constant = size.height - 10
        
    }
    
}
