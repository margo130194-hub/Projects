//
//  NotificationsViewController.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 16/05/2026.
//

import UIKit

final class NotificationViewController: UIViewController {
    
    static func build() -> UIViewController{
        let vc = NotificationViewController()
        let presenter = NotificationPresenter()
        
        vc.presenter = presenter
        presenter.view = vc
        
        return vc
    }
    
    var presenter: NotificationPresenterProtocol?
    
    // MARK: - Subviews
    private let label = UILabel()
    private let pushLabel = UILabel()
    
    private let imageBackground = UIImageView()
    private let pushSwitch = UISwitch()
    private let stackView = UIStackView()
    private let conteinerView = UIView()
    
    // MARK: - Lifecycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        title = "Уведомления"
        view.backgroundColor = .clear
        imageBackground.image = UIImage(named: "space")
        imageBackground.contentMode = .scaleAspectFill
        imageBackground.translatesAutoresizingMaskIntoConstraints = false
        imageBackground.clipsToBounds = true
        view.addSubview(imageBackground)
    }
    
    private func setupSubviews() {
        conteinerView.backgroundColor = UIColor(named: "myBlue")?.withAlphaComponent(0.7)
        conteinerView.layer.borderWidth = 0.5
        conteinerView.layer.cornerRadius = 10
        conteinerView.layer.borderColor = UIColor(named: "GravityColor")?.withAlphaComponent(0.5).cgColor
        conteinerView.layer.shadowColor = UIColor.white.cgColor
        conteinerView.layer.shadowOffset = .zero
        conteinerView.layer.shadowRadius = 3
        conteinerView.layer.shadowOpacity = 0.2
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(conteinerView)
        
        label.text = "Оставайтесь на связи с орбитой Gravity Bank! Включите уведомления, чтобы первыми получать важную информацию и космические советы"
        label.textColor = .white
        label.font = UIFont(name: "FunnelDisplay-Medium", size: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.addSubview(label)
        
        pushLabel.text = "Push-уведомления"
        pushLabel.textColor = UIColor(named: "GravityColor")
        pushLabel.font = UIFont(name: "FunnelDisplay-Bold", size: 25)
        pushLabel.numberOfLines = 0
        pushLabel.translatesAutoresizingMaskIntoConstraints = false
        
        pushSwitch.onTintColor = UIColor(named: "myBlue")
        pushSwitch.translatesAutoresizingMaskIntoConstraints = false
        pushSwitch.addTarget(self, action: #selector(action), for: .valueChanged)
        
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(pushLabel)
        stackView.addArrangedSubview(pushSwitch)
        view.addSubview(stackView)
    }
    
    //    MARK: - Conctraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            conteinerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            conteinerView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            conteinerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            conteinerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            label.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -20)
        ])
    }
    
    //    MARK: - Action
    @objc private func action (_ sender: UISwitch){
        presenter?.notificationSwitch(isOn: sender.isOn)
    }
}
//    MARK: - Extensions
extension NotificationViewController: NotificationViewProtocol{
    func setupSwitch(isOn: Bool) {
        pushSwitch.setOn(isOn, animated: true)
    }
}



