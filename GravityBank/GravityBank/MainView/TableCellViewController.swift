//
//  TableCellViewController.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 01/05/2026.
//

import UIKit

class TableCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    //    MARK: - Labels
    private let name = UILabel()
    private let currency = UILabel()
    private let percent = UILabel()
    private let minimal = UILabel()
    private let depositTerm = UILabel()
    
    //   MARK: - View & Stack
    private let conteinerView = UIView()
    private let stackView = UIStackView()
    
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
        currency.text = nil
        percent.text = nil
        minimal.text = nil
        depositTerm.text = nil
    }
    private func setupViewProperties(){
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    private  func setupSubview(){
        
        //   MARK: - View & Stack
        conteinerView.backgroundColor = UIColor(named: "blue")?.withAlphaComponent(0.7)
        conteinerView.layer.borderWidth = 0.5
        conteinerView.layer.cornerRadius = 10
        conteinerView.layer.borderColor = UIColor(named: "GravityColor")?.withAlphaComponent(0.5).cgColor
        conteinerView.layer.shadowColor = UIColor.white.cgColor
        conteinerView.layer.shadowOffset = .zero
        conteinerView.layer.shadowRadius = 3
        conteinerView.layer.shadowOpacity = 0.2
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(conteinerView)
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.addSubview(stackView)
        
        //    MARK: - Labels
        name.font = UIFont(name: "FunnelDisplay-Bold", size: 25)
        name.textColor = .white
        name.numberOfLines = 0
        name.textAlignment = .natural
        name.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.addSubview(name)
        
        [currency, percent, minimal, depositTerm].forEach {
            $0.font = UIFont(name: "FunnelDisplay-Regular", size: 20)
            $0.textColor = .white
            $0.numberOfLines = 0
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
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
            
            stackView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -20),
        ])
    }
    
    func configure(with deposit: Deposit, index: Int){
        name.text = deposit.name
        currency.text = "Валюта: \(deposit.cleanCurrency)"
        percent.text = "Процент по вкладу: \(deposit.percent)"
        minimal.text = "Минимальный вклад: \(deposit.minimal) \(deposit.cleanCurrency)"
        depositTerm.text = "Срок депозита: \(deposit.depositTerm)"
    }
}

