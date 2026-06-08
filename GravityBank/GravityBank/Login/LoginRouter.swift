//
//  LoginRouter.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 29/05/2026.
//

import UIKit

final class LoginRouter: LoginRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func navigateToMainView() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            UIView.transition(with: window, duration: 0.3,options: .transitionCrossDissolve){
                window.rootViewController = TabBarViewController()
            }
        }
    }
    
    func navigateToSignUp() {
        let signUp = SignUpViewController.build()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            UIView.transition(with: window, duration: 0.3,options: .transitionCrossDissolve){
                window.rootViewController = signUp
            }
        }
    }
}
