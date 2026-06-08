//
//  OnboardingViewController.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 02/04/2026.
//

import UIKit
protocol OnboardingViewControllerDelegate: AnyObject{
    func finishOnboarding()
}

class OnboardingViewController: UIViewController {
    
    weak var delegate: OnboardingViewControllerDelegate?
    
    // MARK: - Subviews
    private let image = UIImageView()
    private let imageBackground = UIImageView()
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private var pageData:(imageName: String, title: String, description: String)?
    private let startButton = UIButton(type: .system)
    var isFinalPage: Bool = false
    
    // MARK: - Lifecycles
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
        view.backgroundColor = .clear
    }
    
    private func setupSubviews() {
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont(name: "FunnelDisplay-Bold", size: 30)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = UIFont(name: "FunnelDisplay-Medium", size: 20)
        descriptionLabel.textColor = UIColor(named: "GravityColor")
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.setTitle("Начать", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = UIFont(name: "FunnelDisplay-Bold", size: 18)
        startButton.backgroundColor = .black
        startButton.layer.cornerRadius = 10
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.layer.borderWidth = 1
        startButton.layer.shadowColor = UIColor.white.withAlphaComponent(1).cgColor
        startButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        startButton.layer.shadowOpacity = 0.8
        startButton.layer.shadowRadius = 3
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        
        view.addSubview(startButton)
        view.addSubview(image)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
    }
    
    //    MARK: - Conctraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 150),
            image.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //    MARK: - Actions
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
        
        delegate?.finishOnboarding()
    }
}
