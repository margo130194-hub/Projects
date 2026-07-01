//
//  PagesViewController.swift
//  Pet Advisor
//
//  Created by Margarita Matsonko on 09/04/2026.
//
import UIKit

final class ContainerViewController: UIViewController {
    
    private let coordinator: ContainerCoordinatorProtocol
    
    init(coordinator: ContainerCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Subviews
    private let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private let page1 = OnboardingViewController()
    private let page2 = OnboardingViewController()
    private let page3 = OnboardingViewController()
    lazy var pages:[UIViewController] = [page1, page2, page3]
    private let skipButton = UIButton(type: .system)
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupPages()
        setupSubview()
        setupConstraints()
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .beige
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
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        appearance.currentPageIndicatorTintColor = .darkBrown
        appearance.pageIndicatorTintColor = .darkBrown.withAlphaComponent(0.5)
        
        skipButton.setTitle("Skip", for: .normal)
        skipButton.backgroundColor = .clear
        skipButton.setTitleColor(.darkBrown.withAlphaComponent(0.8), for: .normal)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.titleLabel?.font = UIFont(name: "FunnelDisplay-Medium", size: 16)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        view.addSubview(skipButton)
        
        page1.setData(imageName: "page1", title: "Find the right pet for your lifestyle", description: "Discover pets that match your daily routine, home, and personal preferences")
        page2.setData(imageName: "page2", title: "Match pets to your time, budget, and space", description: "Answer a few simple questions and get recommendations that fit your real life")
        page3.setData(imageName: "page3", title: "Explore care tips, breeds, and monthly costs", description: "Learn what each pet needs before you decide, from daily care to expected expenses")
        page3.isFinalPage = true
        page3.delegate = self
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            skipButton.heightAnchor.constraint(equalToConstant: 32),
            skipButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Actions
    @objc private func skipTapped(){
        coordinator.goToLogin()
    }
    
}
// MARK: - Extensions
extension ContainerViewController: OnboardingViewControllerDelegate{
    func finishOnboarding() {
        coordinator.goToLogin()
    }
}

extension ContainerViewController: UIPageViewControllerDataSource{
    
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

extension ContainerViewController: UIPageViewControllerDelegate{
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

