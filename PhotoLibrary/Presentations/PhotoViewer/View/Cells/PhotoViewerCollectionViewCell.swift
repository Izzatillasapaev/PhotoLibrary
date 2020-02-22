//
//  PhotoViewerCollectionViewCell.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 22.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class PhotoViewerCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    var onShare: (_ url: String, _ image: UIImage, _ text: String) -> () = {_,_,_  in}
    var photo: Photo?
    override func awakeFromNib() {
        super.awakeFromNib()
        myScrollView.delegate = self
        myScrollView.minimumZoomScale = 1.0
        myScrollView.maximumZoomScale = 3.5
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return backImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        //        scrollView.zoomScale = 1.0
    }
    
    @IBAction func sharePressed(_ sender: Any) {
        if photo == nil {
            return
        }
        self.onShare(photo!.baseUrl, self.backImageView.image ?? UIImage(named: "default")!, photo!.filename)
    }
    
    func configure(photo: Photo, onShare: @escaping (_ url: String, _ image: UIImage, _ text: String) -> (), size: CGSize) {
        
        widthConstraint.constant = size.width
        heightConstraint.constant = size.height
        
        nameLabel.text = photo.filename
        if let date = photo.getCreatedDate()?.toString(with: "dd MMMM yyyy") {
            dateLabel.isHidden = false
            dateLabel.text = date
        }
        else {
            dateLabel.isHidden = true
        }
        self.onShare = onShare
        self.photo = photo
        self.backImageView.imageFromServerURL(photo.baseUrl)
        self.myScrollView.contentSize = size
    }
}
