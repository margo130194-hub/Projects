//
//  MainOnboardingViewController.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 02/04/2026.
//

import UIKit

class ContainerOnboardingViewController: UIViewController {
    
    static func build() -> UIViewController{
        let vc = ContainerOnboardingViewController()
        let router = ContainerOnboardingRouter()
        
        vc.router = router
        router.viewController = vc
        
        return vc
    }
    
    var router: ContainerOnboardingRouterProtocol?
    
    // MARK: - Subviews
    private let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private let page1 = OnboardingViewController()
    private let page2 = OnboardingViewController()
    private let page3 = OnboardingViewController()
    private let page4 = OnboardingViewController()
    lazy var pages:[UIViewController] = [page1, page2, page3, page4]
    private let skipButton = UIButton(type: .system)
    private let imageBackground = UIImageView()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
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
    
    //    MARK: - Layout
    private func setupViewProperties() {
        imageBackground.image = UIImage(named: "space")
        imageBackground.alpha = 0.6
        imageBackground.contentMode = .scaleToFill
        imageBackground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageBackground)
    }
    
    private func setupSubview(){
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        appearance.currentPageIndicatorTintColor = .white
        appearance.pageIndicatorTintColor = .white.withAlphaComponent(0.5)
        
        skipButton.setTitle("Пропустить", for: .normal)
        skipButton.setTitleColor(.white.withAlphaComponent(0.7), for: .normal)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        
        skipButton.titleLabel?.font = UIFont(name: "FunnelDisplay-Bold", size: 15)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        view.addSubview(skipButton)
        
        page1.setData(imageName: "smartBanking", title: "Интеллектуальные решения для вашего будущего.", description: "Управляйте капиталом, следите за расходами и приумножайте сбережения — всё в одном приложении.")
        page2.setData(imageName: "security", title: "Ваша безопасность — наш главный приоритет.", description: "Просто введите ваш номер телефона, чтобы начать. Ваша конфиденциальность защищена шифрованием высшего уровня на каждом этапе.")
        page3.setData(imageName: "cashback", title: "Получайте выгоду каждый день.", description: "Получайте кэшбэк до 10% в любимых категориях и пользуйтесь эксклюзивными скидками от партнеров.")
        page4.setData(imageName: "ready", title: " Готовы начать?", description: "Авторизуйтесь по номеру телефона или создайте новый аккаунт всего за пару минут.")
        page4.isFinalPage = true
        page4.delegate = self
    }
    
    //    MARK: - Conctraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            skipButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    //    MARK: - Actions
    @objc private func skipTapped(){
        router?.goToLogin()
    }
}

//    MARK: - Extensions

extension ContainerOnboardingViewController: OnboardingViewControllerDelegate{
    func finishOnboarding() {
        router?.goToLogin()
    }
}

extension ContainerOnboardingViewController: UIPageViewControllerDataSource{
    
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

extension ContainerOnboardingViewController: UIPageViewControllerDelegate{
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
