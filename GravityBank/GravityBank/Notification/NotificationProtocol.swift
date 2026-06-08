//
//  NotificationProtocol.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 31/05/2026.
//

import Foundation

protocol NotificationPresenterProtocol: AnyObject{
    func notificationSwitch(isOn: Bool)
    func viewDidLoad()
}

protocol NotificationViewProtocol: AnyObject{
    func setupSwitch(isOn: Bool)
}

protocol NotificationRouterProtocol: AnyObject{
    
    
}
