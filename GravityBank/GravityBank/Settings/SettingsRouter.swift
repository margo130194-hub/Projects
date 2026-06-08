//
//  SettingsRouter.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 30/05/2026.
//

import UIKit

final class SettingsRouter: SettingsRouterProtocol{
   
    weak var viewController: UIViewController?
    
    func navigateToLogin() {
        let vc = LoginViewController.build()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            UIView.transition(with: window, duration: 0.3,options: .transitionCrossDissolve){
                window.rootViewController = vc
            }
        }
    }
}
