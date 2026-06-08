//
//  AnnotationView.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 05/06/2026.
//

import Foundation
import MapKit

final class AtmAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    let atmData: ATM
    
    init(atm: ATM, latitude: Double, longitude: Double){
        self.atmData = atm
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        self.title = "Gravity Bank"
        self.subtitle = atm.Address.streetName
        super .init()
    }
    
}
