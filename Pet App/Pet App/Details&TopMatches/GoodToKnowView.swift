//
//  GoodToKnowView.swift
//  Pet App
//
//  Created by Margarita Matsonko on 30/06/2026.
//

import UIKit

final class GoodToKnowView: UIView{
    
    private var items: [Info] = []
    private let conteinerView = UIView()
    private let nameLabel = UILabel()
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor  = .clear
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spacing: CGFloat = 10
        let items: CGFloat = 3
        let totalSpacing = spacing * (items - 1)
        let width = (collectionView.bounds.width - totalSpacing) / items

        layout.itemSize = CGSize(
            width: width,
            height: 70
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperties()
        setupSubviews()
        setupConctraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperties(){
        conteinerView.backgroundColor = .white.withAlphaComponent(0.4)
        conteinerView.layer.borderWidth = 0.5
        conteinerView.layer.cornerRadius = 18
        conteinerView.layer.borderColor = UIColor.darkBrown.withAlphaComponent(0.5).cgColor
        conteinerView.layer.shadowColor = UIColor.white.cgColor
        conteinerView.layer.shadowOffset = .zero
        conteinerView.layer.shadowRadius = 3
        conteinerView.layer.shadowOpacity = 0.2
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(conteinerView)
    }
    
    func setupSubviews(){
        nameLabel.text = "Good To Know"
        nameLabel.font = UIFont(name: "FunnelDisplay-Bold", size: 20)
        nameLabel.textColor = .darkBrown
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.addSubview(nameLabel)
        
        collectionView.dataSource = self
        collectionView.register(GoodToKnowCell.self, forCellWithReuseIdentifier: GoodToKnowCell.identifier)
        conteinerView.addSubview(collectionView)
    }
    
    private func setupConctraints(){
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: self.topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            conteinerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 10),
            
            collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -10),
            collectionView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 10)
        ])
    }
    
    func configure(with items: [Info]) {
        self.items = items
        collectionView.reloadData()
    }
}

extension GoodToKnowView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoodToKnowCell.identifier, for: indexPath) as? GoodToKnowCell else {
            return UICollectionViewCell()
        }
        let information = items[indexPath.item]
        cell.configure(with: information)
        return cell
    }
}

