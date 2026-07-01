//
//  Coordinator.swift
//  Pet App
//
//  Created by Margarita Matsonko on 23/06/2026.
//

import UIKit

// MARK: - Protocol

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get set }
    func start()
}
