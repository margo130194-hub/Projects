//
//  AtmInfo.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 07/06/2026.
//

import UIKit

final class AtmInfoViewController: UIViewController{
    
    // MARK: - Subviews
    private let infoLabel = UILabel()
    private let atm: ATM
    
    init(atm: ATM) {
        self.atm = atm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    //    MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
    }
    
    private func  setupSubviews(){
        infoLabel.textColor = UIColor(named: "GravityColor")
        infoLabel.font = UIFont(name: "FunnelDisplay-Medium", size: 20)
        infoLabel.numberOfLines = 0
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoLabel)
        
        let street = atm.Address.streetName ?? ""
        let town = atm.Address.townName
        let building = atm.Address.buildingNumber ?? ""
        let place = "г. \(town), \(street) \(building)"
        let status = atm.currentStatus == "On" ? "✅ Открыт" : "❌ Закрыт"
        let service = atm.services?.joined(separator: ",") ?? "Снятие наличных"
        infoLabel.text = """
            Gravity Bank
            Mы находимся по адресу 🏠 :   
            \(place)
            Принимаемая валюта 💵: \(atm.currency ?? "BYN")
            Предоставляемые услуги 💼: \(service)
            \(status)
            """
    }
    
    //    MARK: - Conctraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
}
