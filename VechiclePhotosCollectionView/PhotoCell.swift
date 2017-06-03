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
}
