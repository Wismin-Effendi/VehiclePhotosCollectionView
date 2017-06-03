//
//  VehicleCollectionViewController.swift
//  VechiclePhotosCollectionView
//
//  Created by Wismin Effendi on 6/3/17.
//  Copyright © 2017 iShinobi. All rights reserved.
//

import UIKit


class VehicleCollectionViewController: UICollectionViewController {

    
    var carPhotos = [Photo]()
    var helicopterPhotos = [Photo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 1...15 {
            if i > 9 {
                carPhotos.append(Photo(title: "Title #\(i)", kind: .car, imageName: "images/car\(i).jpeg"))
            } else {
                carPhotos.append(Photo(title: "Title #0\(i)", kind: .car, imageName: "images/car0\(i).jpeg"))
            }
        }

    }


    // MARK: UICollectionViewDataSource/Users/wismin-effendi/Developer/CareerFoundry/Module_1/assets_download/collectionView/images

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCell
    
        let photo = carPhotos[indexPath.row]
        cell.photo = photo
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
