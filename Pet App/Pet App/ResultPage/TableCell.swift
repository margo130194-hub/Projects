//
//  TableCell.swift
//  Pet App
//
//  Created by Margarita Matsonko on 25/06/2026.
//
import UIKit

class TableCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    var onLearnMoreTapped:(() -> Void)?
    // MARK: - Subviews
    private let image = UIImageView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let button = UIButton(type: .system)
    private let conteinerView = UIView()
    private let stackView = UIStackView()
    
    
    // MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        descriptionLabel.text = nil
        image.image = nil
        
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    private func setupSubviews() {
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
        
        nameLabel.font = UIFont(name: "FunnelDisplay-Bold", size: 18)
        nameLabel.textColor = .darkBrown
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 1
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.8
        conteinerView.addSubview(nameLabel)
        
        descriptionLabel.font = UIFont(name: "FunnelDisplay-Regular", size: 13)
        descriptionLabel.textColor = .darkBrown
        descriptionLabel.textAlignment = .left
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = .byTruncatingTail
        conteinerView.addSubview(descriptionLabel)
        
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.addSubview(image)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "FunnelDisplay-Regular", size: 18)!,
            .foregroundColor: UIColor.darkBrown.withAlphaComponent(0.7),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedTitle = NSAttributedString(
            string: "Learn more →",
            attributes: attributes
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.darkBrown.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(learnMoreTapped), for: .touchUpInside)
        conteinerView.addSubview(button)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            conteinerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            image.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 7),
            image.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 12),
            image.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: 7),
            image.widthAnchor.constraint(equalToConstant: 90),
            image.heightAnchor.constraint(equalToConstant: 90),
            
            nameLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -10),
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 60),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 25),
            descriptionLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -10),
            
            button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            button.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 25),
            button.trailingAnchor.constraint(lessThanOrEqualTo: conteinerView.trailingAnchor, constant: -12),
            button.bottomAnchor.constraint(lessThanOrEqualTo: conteinerView.bottomAnchor, constant: -12),
            button.heightAnchor.constraint(equalToConstant: 10)
            
        ])
    }
    //    MARK: - Actions
    func configure(with pet: RecommendedPets){
        nameLabel.text = pet.name
        descriptionLabel.text = pet.description
        image.image = UIImage(named: pet.imageName)
    }
    
    @objc private func learnMoreTapped(){
        onLearnMoreTapped?()
    }
}

// MARK: - Extensions
