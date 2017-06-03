//
//  Photo.swift
//  VechiclePhotosCollectionView
//
//  Created by Wismin Effendi on 6/3/17.
//  Copyright © 2017 iShinobi. All rights reserved.
//

import UIKit

class Photo {
    var title: String
    var kind: Kind
    var imageName: String
    
    init(title: String, kind: Kind, imageName: String) {
        self.title = title
        self.kind = kind
        self.imageName = imageName
    }
}


enum Kind: Int {
    case car
    case helicopter
    
    func description() -> String {
        switch self {
        case .car:
            return "Cars"
        case .helicopter:
            return "Helicopters"
        }
    }
}
