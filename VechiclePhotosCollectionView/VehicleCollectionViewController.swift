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
    var allPhotos = [[Photo]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = collectionView!.frame.width / 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)

        for i in 1...15 {
            if i > 9 {
                carPhotos.append(Photo(title: "Car #\(i)", kind: .car, imageName: "images/car\(i).jpeg"))
            } else {
                carPhotos.append(Photo(title: "Car #0\(i)", kind: .car, imageName: "images/car0\(i).jpeg"))
            }
        }

        for i in 1...15 {
            if i > 9 {
                helicopterPhotos.append(Photo(title: "Helicopter #\(i)", kind: .car, imageName: "images/chop\(i).jpeg"))
            } else {
                helicopterPhotos.append(Photo(title: "Helicopter #0\(i)", kind: .car, imageName: "images/chop0\(i).jpeg"))
            }
        }
        
        allPhotos.append(carPhotos)
        allPhotos.append(helicopterPhotos)
    }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return allPhotos.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCell
    
        let photo = allPhotos[indexPath.section][indexPath.row]
        cell.photo = photo
    
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! PhotoHeader
        var title = ""
        
        if let kind = Kind(rawValue: indexPath.section) {
            title = kind.description()
        }
        
        sectionHeader.title = title
        
        return sectionHeader
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
