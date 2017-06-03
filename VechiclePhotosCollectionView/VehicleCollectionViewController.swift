//
//  VehicleCollectionViewController.swift
//  VechiclePhotosCollectionView
//
//  Created by Wismin Effendi on 6/3/17.
//  Copyright © 2017 iShinobi. All rights reserved.
//

import UIKit


class VehicleCollectionViewController: UICollectionViewController {

    // ui obj 
    var editButton: UIBarButtonItem?
    var addButton: UIBarButtonItem?
    var deleteButton: UIBarButtonItem?
    var cancelButton: UIBarButtonItem?
    
    var selectedIndexPaths = Set<IndexPath>()  // Use Set to avoid duplicate items
    
    // Don't confuse this with isEditing which is buildIn  method for automatic handling of Edit/Done
    var editingMode: Bool = false {
        didSet {
            collectionView?.allowsMultipleSelection = editingMode
            collectionView?.selectItem(at: nil, animated: true, scrollPosition: UICollectionViewScrollPosition())
            selectedIndexPaths.removeAll(keepingCapacity: false)
        }
    }
    
    
    // for model data
    var carPhotos = [Photo]()
    var helicopterPhotos = [Photo]()
    var allPhotos = [[Photo]]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showEditButton()
        self.installsStandardGestureForInteractiveMovement = true // to enable gesture for cell reordering 
        
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
    
    
    // MARK: - show  UIBarButtonItem(s) programmatically
    private func showEditButton() {
        editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped(_:)))
        editButton!.isEnabled = true
        self.navigationItem.setRightBarButtonItems([editButton!], animated: true)
        
        addButton?.isEnabled = false
        deleteButton?.isEnabled = false
        cancelButton?.isEnabled = false
        
        // disable Editing mode
        editingMode = false
    }
    
    
    
    private func showAddDeleteCancelButton() {
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
        deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped(_:)))
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped(_:)))
        addButton!.isEnabled = true
        deleteButton!.isEnabled = true
        cancelButton!.isEnabled = true
        self.navigationItem.setRightBarButtonItems([cancelButton!, deleteButton!, addButton!], animated: true)
        editButton?.isEnabled = false
        
        // enable Editing mode
        editingMode = true
    }

    
    // MARK: button actions 
    func editButtonTapped(_ sender: UIBarButtonItem) {
        showAddDeleteCancelButton()
    }
    
    func addButtonTapped(_ sender: UIBarButtonItem) {
        let randomLessThan10 = arc4random_uniform(10)
        let i = randomLessThan10
        let photo0 = Photo(title: "New Car", kind: .car, imageName: "images/extra_car0\(i).jpeg")
        let photo1 = Photo(title: "New Helicopter", kind: .car, imageName: "images/extra_chop0\(i).jpeg")
        let index0 = allPhotos[0].count
        let index1 = allPhotos[1].count
        allPhotos[0].append(photo0)
        allPhotos[1].append(photo1)
        let indexPath0 = IndexPath(item: index0, section: 0)
        let indexPath1 = IndexPath(item: index1, section: 1)
        collectionView?.insertItems(at: [indexPath0, indexPath1])
    }
    
    
    func deleteButtonTapped(_ sender: UIBarButtonItem) {
        collectionView?.performBatchUpdates({ _ in
            
            let selectedIndexPathsInReverseOrder = self.selectedIndexPaths.sorted(by: self.sortIndexPathsReverse)
            print("Content of selectedPath reverse order: \(selectedIndexPathsInReverseOrder)")
            for indexPath in selectedIndexPathsInReverseOrder {
                print(indexPath)
                self.allPhotos[indexPath.section].remove(at: indexPath.row)
            }
            self.collectionView?.deleteItems(at: selectedIndexPathsInReverseOrder)
        }, completion: nil)
        
        // emptied the selectedIndexPaths for deletion 
        selectedIndexPaths.removeAll()
    }
    
    func cancelButtonTapped(_ sender: UIBarButtonItem) {
        // emptied the selectedIndexPaths for deletion
        selectedIndexPaths.removeAll()
        
        // and
        showEditButton()
    }

    
    // MARK: - helper for sorting IndexPath in reverse order 
    // We need to sort in reverse order since we allow deletion of multiple items in one click 
    // Thus we should delete from the end, or else we'll delete the wrong item or get into index out of bounds
    // sort in reverse order prevent that from happening.
    private func sortIndexPathsReverse(indexPath1: IndexPath, indexPath2: IndexPath) -> Bool {
        if indexPath1.section > indexPath2.section {
            return true
        } else if (indexPath1.section < indexPath2.section) {
            return false
        } else if (indexPath1.row >= indexPath2.row) {
            return true
        } else {
            return false
        }
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
    
    // added for cell reordering
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = allPhotos[sourceIndexPath.section][sourceIndexPath.row]
        
        allPhotos[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        
        if sourceIndexPath.section == destinationIndexPath.section {
            allPhotos[sourceIndexPath.section].insert(itemToMove, at: destinationIndexPath.row)
        } else {
            allPhotos[destinationIndexPath.section].insert(itemToMove, at: destinationIndexPath.row)
        }
    }
    
    // added for cell deletion
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard editingMode else { return }
        selectedIndexPaths.insert(indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard editingMode else { return }
        
        if let indexInSelectedIndexPaths = selectedIndexPaths.index(of: indexPath) {
            selectedIndexPaths.remove(at: indexInSelectedIndexPaths)
        }
        
    }
    
    
    
    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return editingMode
    }
    

}
