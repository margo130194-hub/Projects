//
//  OnboardingViewController.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 02/04/2026.
//

import UIKit

 class OnboardingViewController: UIViewController {
    
    // MARK: - Subviews
    private let image = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private var pageData:(imageName: String, title: String, description: String)?
    private let startButton = UIButton(type: .system)
    var isFinalPage: Bool = false
     
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        updateData()
      
    }
     
     override func viewWillAppear(_ animated: Bool){
         super.viewWillAppear(animated)
         if isFinalPage{
             startButton.isHidden = false
         } else {
             startButton.isHidden = true
         }
     }
    
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = .systemFont(ofSize: 30, weight: .medium)
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.isHidden = true
        startButton.backgroundColor = .gray
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.layer.borderWidth = 1.5
        startButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        startButton.layer.shadowOpacity = 0.8
        startButton.layer.shadowRadius = 3
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
       
        view.addSubview(startButton)
        view.addSubview(image)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
       
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 150),
            image.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            
            startButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 80),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
     func setData(imageName: String, title: String, description: String){
         self.pageData = (imageName: imageName, title: title, description: description)
         
             updateData()
         }
     
     func updateData(){
        guard let data = pageData else {return}
        image.image = UIImage(named: data.imageName)
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }
     
     @objc private func startTapped(){
         UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
         let loginVC = LoginViewController()
         guard let window = view.window else { return }
            view.window?.rootViewController = loginVC
            view.window?.makeKeyAndVisible()
         
         UIView.transition(with: window,
                           duration: 0.3,
                           options: .transitionCrossDissolve,
                           animations: nil)
     }
}

