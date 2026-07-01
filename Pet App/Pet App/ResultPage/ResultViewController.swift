//
//  ResultViewController.swift
//  Pet App
//
//  Created by Margarita Matsonko on 25/06/2026.
//

import UIKit

final class ResultViewController: UIViewController {
    
    private let viewModel: ResultViewModel
    
    init(viewModel: ResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    private let table = UITableView()
    private let image = UIImageView()
    private let nameLabel = UILabel()
    private let explanationLabel = UILabel()
    private let noteLabel = UILabel()
    private let petsButton = UIButton(type: .system)
    
    //MARK: - Properties
    private var recommendedPets: [RecommendedPets] = []
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        bindViewModel()
        viewModel.updateResult()
    }
    
    private func bindViewModel(){
        viewModel.recommendedPets.bind {[weak self] pets in
            DispatchQueue.main.async {
            guard let self = self else {return}
                self.recommendedPets = pets
                print("Pets count:", pets.count)
                self.table.reloadData()
            }
        }
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .beige
    }
    
    private func setupSubviews() {
        image.image = UIImage(named: "picture")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        
        nameLabel.text = "Great match!"
        nameLabel.textColor = .darkBrown
        nameLabel.font = UIFont(name: "FunnelDisplay-Bold", size: 30)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        explanationLabel.text = "Based on your answers, these pets might be the perfect companions for you."
        explanationLabel.font = UIFont(name: "FunnelDisplay-Regular", size: 20)
        explanationLabel.textColor = .darkBrown
        explanationLabel.textAlignment = .center
        explanationLabel.numberOfLines = 0
        explanationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(explanationLabel)
        
        table.separatorStyle = .none
        table.rowHeight = 140
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.register(TableCell.self, forCellReuseIdentifier: TableCell.reuseIdentifier)
        view.addSubview(table)
        
        petsButton.setTitleColor(.beige, for: .normal)
        petsButton.setTitle("See more matches →", for: .normal)
        petsButton.titleLabel?.font = UIFont(name: "FunnelDisplay-Regular", size: 20)
        petsButton.titleLabel?.textAlignment = .center
        petsButton.layer.cornerRadius = 18
        petsButton.backgroundColor = .darkBrown
        petsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(petsButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            image .centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 180),
            image.heightAnchor.constraint(equalToConstant: 90),
            
            nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            explanationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            explanationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            explanationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            table.topAnchor.constraint(equalTo: explanationLabel.bottomAnchor, constant: 5),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            table.bottomAnchor.constraint(equalTo: petsButton.topAnchor, constant: -15),
            
            petsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            petsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            petsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            petsButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    //    MARK: - Actions
    
}

// MARK: - Extensions
extension ResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(recommendedPets.count)
        return recommendedPets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.reuseIdentifier, for: indexPath) as? TableCell else {
            return UITableViewCell()
        }
        let pet = recommendedPets[indexPath.row]
        cell.configure(with: pet)
        
        cell.onLearnMoreTapped = { [weak self] in
            self?.viewModel.openDetails(pet)
        }
        return cell
        
        
    }
}
