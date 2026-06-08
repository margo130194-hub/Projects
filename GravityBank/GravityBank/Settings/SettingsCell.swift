//
//  SettingsCell.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 14/05/2026.
//

import UIKit

class SettingCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    //    MARK: - Subviews
    private let conteinerView = UIView()
    private let name = UILabel()
    
    //    MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewProperties()
        setupSubview()
        setupConctraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
    }
    
    //    MARK: - Layout
    private func setupViewProperties(){
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    private  func setupSubview(){
        conteinerView.backgroundColor = UIColor(named: "blue")?.withAlphaComponent(0.7)
        conteinerView.layer.borderWidth = 0.5
        conteinerView.layer.cornerRadius = 10
        conteinerView.layer.borderColor = UIColor(named: "GravityColor")?.withAlphaComponent(0.5).cgColor
        conteinerView.layer.shadowColor = UIColor.white.cgColor
        conteinerView.layer.shadowOffset = .zero
        conteinerView.layer.shadowRadius = 3
        conteinerView.layer.shadowOpacity = 0.4
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(conteinerView)
        
        name.font = UIFont(name: "FunnelDisplay-Bold", size: 25)
        name.textColor = .white
        name.numberOfLines = 0
        name.textAlignment = .left
        name.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.addSubview(name)
    }
    
    //    MARK: - Conctraints
    private func setupConctraints(){
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            conteinerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            name.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -20),
        ])
    }
    
    //    MARK: - Actions
    func configure(with model: SettingsModel, index: Int){
        name.text = model.name
    }
}


