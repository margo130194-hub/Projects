//
//  SceneDelegate.swift
//  Pet App
//
//  Created by Margarita Matsonko on 15/06/2026.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let rootNavigationController = UINavigationController()
        
        appCoordinator = AppCoordinator(navigationController: rootNavigationController, window: window)
        appCoordinator?.start()
        self.window = window
        
    }
        func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
            guard let url = URLContexts.first?.url else { return }
            
            GIDSignIn.sharedInstance.handle(url)
        }
    }

