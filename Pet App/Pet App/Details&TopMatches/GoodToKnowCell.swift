//
//  GoodToKnowCell.swift
//  Pet App
//
//  Created by Margarita Matsonko on 30/06/2026.
//
import UIKit


class GoodToKnowCell: UICollectionViewCell {
    
    static var identifier: String = "Cell"
    
    private let title = UILabel()
    private let value = UILabel()
    private let icon = UIImageView()
    private let conteinerView = UIView()
    
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
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }
    
    private func setupSubview(){
        conteinerView.backgroundColor = .white.withAlphaComponent(0.4)
        conteinerView.layer.borderWidth = 0.5
        conteinerView.layer.cornerRadius = 18
        conteinerView.layer.borderColor = UIColor.darkBrown.withAlphaComponent(0.5).cgColor
        conteinerView.layer.shadowColor = UIColor.white.cgColor
        conteinerView.layer.shadowOffset = .zero
        conteinerView.layer.shadowRadius = 3
        conteinerView.layer.shadowOpacity = 0.2
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(conteinerView)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
        icon.tintColor = .secondaryBrown
        conteinerView.addSubview(icon)
        
        title.font = UIFont(name: "FunnelDisplay-Regular", size: 20)
        title.textColor = .secondaryBrown
        title.numberOfLines = 0
        title.textAlignment = .left
        title.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.addSubview(title)
        
        value.font = UIFont(name: "FunnelDisplay-Regular", size: 20)
        value.numberOfLines = 0
        value.textAlignment = .right
        value.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.addSubview(value)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            conteinerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            icon.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 5),
            icon.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 5),
            icon.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -5),
            
            title.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -10),
            
            value.topAnchor.constraint(equalTo: title.topAnchor, constant: 5),
            value.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
            value.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -10),
            
            
        ])
    }
    
    func configure(with information: Info){
        title.text = information.titleInfo
        icon.image = UIImage(systemName: information.iconInfo)
        value.text = information.valueInfo
    }
}
