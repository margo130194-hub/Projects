//
//  TabBarCoordinator.swift
//  Pet App
//
//  Created by Margarita Matsonko on 23/06/2026.
//

import UIKit

final class TabBarCoordinator: Coordinator, QuizCoordinatorProtocol {
   
    private let tabBar = TabBarViewController()
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator]
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    func start() {
        
        let quizViewModel = QuizViewModel(coordinator: self)
        
        let firstVC = QuizViewController(viewModel: quizViewModel)
        let secondVC = MainViewController()
        let thirdVC = SettingsViewController()
        
        let firstNav = UINavigationController(rootViewController: firstVC)
        let secondNav = UINavigationController(rootViewController: secondVC)
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        
        firstNav.tabBarItem = UITabBarItem(
            title: "Quiz",
            image: UIImage(systemName: "list.bullet.clipboard"),
            selectedImage: UIImage(systemName: "list.bullet.clipboard.fill"))
        
        secondNav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"))
        
        thirdNav.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill"))
        
        tabBar.viewControllers = [firstNav, secondNav, thirdNav]
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            UIView.transition(with: window, duration: 0.4,options: .transitionCrossDissolve){
                window.rootViewController = self.tabBar
            }
        }
        
    }
    
    func goToResultPage() {
        let resultViewModel = ResultViewModel()
        let resultVC = ResultViewController(viewModel: resultViewModel)
        let nav = UINavigationController(rootViewController: resultVC)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
            UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve) {
                        window.rootViewController = nav
                    }
                }
    }
}
