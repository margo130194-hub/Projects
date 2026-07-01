//
//  DetailsViewController.swift
//  Pet App
//
//  Created by Margarita Matsonko on 28/06/2026.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    
    private let viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    private let image = UIImageView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let infoLabel = UILabel()
    private let characteristicsCollectionView = CharacteristicsView()
    private let goodToKnowCollectionView = GoodToKnowView()
    private let favoriteButton = UIButton(type: .system)
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        configure()
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .beige
    }
    
    private func setupSubviews() {
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name: "FunnelDisplay-Bold", size: 38)
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .darkBrown
        view.addSubview(nameLabel)
        
        descriptionLabel.font = UIFont(name: "FunnelDisplay-Regular", size: 20)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .darkBrown
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.font = UIFont(name: "FunnelDisplay-Regular", size: 20)
        infoLabel.textColor = .darkBrown
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        view.addSubview(infoLabel)
        
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = .darkBrown
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(favoriteButton)
        
        characteristicsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(characteristicsCollectionView)
        
        goodToKnowCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(goodToKnowCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            favoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            
            image.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 15),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.widthAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: image.leadingAnchor, constant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: image.leadingAnchor, constant: 20),
            
            infoLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            characteristicsCollectionView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            characteristicsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            characteristicsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            goodToKnowCollectionView.topAnchor.constraint(equalTo: characteristicsCollectionView.bottomAnchor, constant: 5),
            goodToKnowCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            goodToKnowCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            goodToKnowCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            
        ])
    }
    //    MARK: - Actions
    func configure(){
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        image.image = UIImage(named: viewModel.imageName)
        goodToKnowCollectionView.configure(with: viewModel.information)
        characteristicsCollectionView.configure(with: viewModel.characteristic)
        infoLabel.text = viewModel.info
    }
}

// MARK: - Extensions
