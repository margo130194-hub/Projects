//
//  SignUpRouter.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 29/05/2026.
//

import UIKit

final class SignUpRouter: SignUpRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func navigateToLogin() {
        let mainVC = LoginViewController.build()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            UIView.transition(with: window, duration: 0.3,options: .transitionCrossDissolve){
                window.rootViewController = mainVC
            }
        }
    }
    
}
