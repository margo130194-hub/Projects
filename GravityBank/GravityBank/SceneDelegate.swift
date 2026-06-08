//
//  SceneDelegate.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 02/04/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        
        let hasSeenOnbording = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        if hasSeenOnbording{
            window?.rootViewController = LoginViewController.build()
        } else {
            window?.rootViewController = ContainerOnboardingViewController.build()
        }
        let savedTheme = UserDefaults.standard.integer(forKey: "selectedTheme")
        if savedTheme == 0 {
            window?.overrideUserInterfaceStyle = .unspecified
        } else {
            window?.overrideUserInterfaceStyle = .dark
        }
        //        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()
    }
}
