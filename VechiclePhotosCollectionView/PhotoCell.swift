//
//  PhotoCell.swift
//  VechiclePhotosCollectionView
//
//  Created by Wismin Effendi on 6/3/17.
//  Copyright © 2017 iShinobi. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet private weak var photoImageView: UIImageView!
    
    var photo: Photo? {
        didSet {
            if let photo = photo {
                photoImageView.image = UIImage(named: photo.imageName)
            }
        }
    }
    
    // MARK: - Properties
    override var isSelected: Bool {
        didSet {
            photoImageView.layer.borderWidth = isSelected ? 3 : 0
        }
    }
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.layer.borderColor = UIColor.cyan.cgColor
        isSelected = false
    }
}
