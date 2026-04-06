//
//  MainOnboardingViewController.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 02/04/2026.
//

import UIKit

 class ViewController: UIViewController {
    
    // MARK: - Subviews
     private let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
     private let page1 = OnboardingViewController()
     private let page2 = OnboardingViewController()
     private let page3 = OnboardingViewController()
     private let page4 = OnboardingViewController()
     lazy var pages:[UIViewController] = [page1, page2, page3, page4]
     private let skipButton = UIButton(type: .system)
     
    
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages()
        setupSubview()
        setupConstraints()
    }
     
    
     private func setupPages(){
         addChild(pageVC)
         view.addSubview(pageVC.view)
         pageVC.didMove(toParent: self)
         
         pageVC.dataSource = self
         pageVC.delegate = self
         
         if let firstPage = pages.first{
             pageVC.setViewControllers([firstPage], direction: .forward, animated: true)
         }
     }
    
     private func setupSubview(){
         
         skipButton.setTitle("Skip", for: .normal)
         skipButton.setTitleColor(.black, for: .normal)
         skipButton.translatesAutoresizingMaskIntoConstraints = false
         skipButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
         skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
         view.addSubview(skipButton)
         
         page1.setData(imageName: "smartBanking", title: "Smart Banking for Your Future.", description: "Manage your money, track expenses, and grow your savings—all in one place.")
         page2.setData(imageName: "security", title: "Your Security is Our Priority.", description: "Just enter your phone number to get started. Your privacy is protected with top-tier encryption every step of the way.")
         page3.setData(imageName: "cashback", title: "Get Rewarded Every Day.", description: "Earn up to 10% cashback on your favorite categories and enjoy exclusive partner discounts.")
         page4.setData(imageName: "ready", title: " Ready to Start?", description: "Log in with your phone number or open a new account in under 2 minutes.")
         page4.isFinalPage = true
     }
     
     private func setupConstraints() {
         NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            skipButton.heightAnchor.constraint(equalToConstant: 60)
         ])
     }
     
     @objc private func skipTapped(){
         let mainVC = LoginViewController()
         mainVC.modalPresentationStyle = .fullScreen
         present(mainVC, animated: true)
     }
}

extension ViewController: UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {return nil}
        let previousIndex = currentIndex - 1
        guard previousIndex >= 0 else {return nil}
        return pages[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {return nil}
        let nextIndex = currentIndex + 1
        guard nextIndex < pages.count else {return nil}
        return pages[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension ViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else {return}
        if let currentVC = pageViewController.viewControllers?.first,
           let index = pages.firstIndex(of: currentVC){
            let isLastPage = (index == pages.count - 1)
            if isLastPage == true{
                skipButton.isHidden = true
            } else {
                skipButton.isHidden = false
            }
        }
    }
}
