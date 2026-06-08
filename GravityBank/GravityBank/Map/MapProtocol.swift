//
//  MapProtocol.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 04/06/2026.
//

import Foundation

protocol MapViewProtocol: AnyObject{
 func showAlert(title: String, message: String)
 func showAtm(_ annotations:[AtmAnnotation])
}

protocol MapPresenterProtocol: AnyObject{
    func viewDidLoad()
    
}

