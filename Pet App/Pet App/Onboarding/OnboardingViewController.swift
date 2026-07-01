//
//  OnboardingViewController.swift
//  Pet Advisor
//
//  Created by Margarita Matsonko on 09/04/2026.
//

import UIKit

protocol OnboardingViewControllerDelegate: AnyObject{
    func finishOnboarding()
}

final class OnboardingViewController: UIViewController {
    
    weak var delegate: OnboardingViewControllerDelegate?
   
    // MARK: - Subviews
    private let image = UIImageView()
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
        view.backgroundColor = .beige
    }
    
    private func setupSubviews() {
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont(name: "FunnelDisplay-Bold", size: 30)
        titleLabel.textColor = .darkBrown
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = UIFont(name: "FunnelDisplay-Regular", size: 18)
        descriptionLabel.textColor = .darkBrown
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.setTitle("Get started", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "FunnelDisplay-Bold", size: 18)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = .darkBrown
        startButton.layer.cornerRadius = 15
        startButton.layer.borderColor = UIColor.beige.cgColor
        startButton.layer.borderWidth = 2
        startButton.layer.shadowColor = UIColor.darkBrown.withAlphaComponent(0.5).cgColor
        startButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        startButton.layer.shadowOpacity = 0.5
        startButton.layer.shadowRadius = 2
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        
        view.addSubview(startButton)
        view.addSubview(image)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 300),
            image.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Actions
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
        delegate?.finishOnboarding()
        
    }
    
}
