//
//  FoodAnnotation.swift
//  CunyHackathon
//
//  Created by Keith Cornish on 4/29/18.
//  Copyright © 2018 Keith Cornish. All rights reserved.
//

import UIKit
import MapKit

class FoodAnnotation: NSObject, MKAnnotation{

    let title: String?
    let type: String
    let tag: Int
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, type: String, tag: Int, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.type = type
        self.tag = tag
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        
        return type
        
    }
    
}
