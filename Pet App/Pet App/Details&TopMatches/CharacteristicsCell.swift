//
//  CharacteristicsCell.swift
//  Pet App
//
//  Created by Margarita Matsonko on 28/06/2026.
//

import UIKit


class CharacteristicsCell: UICollectionViewCell {

    static var identifier: String = "Cell"
    
    private let title = UILabel()
    private let value = UILabel()
    private let icon = UIImageView()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViewProperties()
        setupSubview()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        icon.image =  nil
        title.text  = nil
        value.text = nil
        value.textColor = .secondaryBrown
    }
    
    private func setupViewProperties(){
        contentView.backgroundColor = .white.withAlphaComponent(0.4)
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }
    
    private func setupSubview(){
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
        icon.tintColor = .secondaryBrown
        contentView.addSubview(icon)
        
        title.font = UIFont(name: "FunnelDisplay-Regular", size: 20)
        title.textColor = .secondaryBrown
        title.numberOfLines = 0
        title.textAlignment = .left
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)
        
        value.font = UIFont(name: "FunnelDisplay-Regular", size: 20)
        value.numberOfLines = 0
        value.textAlignment = .right
        value.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(value)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor, constant: 16),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            icon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 20),
            icon.heightAnchor.constraint(equalToConstant: 20),
            
            value.trailingAnchor.constraint(equalTo: icon.leadingAnchor, constant: -8),
            value.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            value.leadingAnchor.constraint(greaterThanOrEqualTo: title.trailingAnchor, constant: 16)
        ])
    }
    
    func configure(with characteristic: Characteristics){
        title.text = characteristic.title
        icon.image = UIImage(systemName: characteristic.icon)
        value.text = characteristic.value
        value.textColor = characteristic.color
    }
    
}
