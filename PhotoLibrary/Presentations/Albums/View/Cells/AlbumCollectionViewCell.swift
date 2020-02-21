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
 
    func configure(album: Album) {
        titleLabel.text = album.title
        
    }
    
}
