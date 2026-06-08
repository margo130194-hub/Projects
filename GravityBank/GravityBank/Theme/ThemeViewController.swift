//
//  ThemeViewController.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 14/05/2026.
//

import UIKit

final class ThemeViewController: UIViewController{
    
    static func build() -> UIViewController {
        let vc = ThemeViewController()
        let presenter = ThemePresenter()
        
        vc.presenter = presenter
        presenter.view = vc
        
        return vc
        
    }
    
    var presenter: ThemePresenterProtocol?
    
    // MARK: - Labels
    private let labelSystem = UILabel()
    private let labelDark = UILabel()
    private let label = UILabel()
    
    // MARK: - Switch
    private let systemSwitch = UISwitch()
    private let darkSwitch = UISwitch()
    
    // MARK: - Stack
    private let systemStackView = UIStackView()
    private let darkStackView = UIStackView()
    private let stackView = UIStackView()
    
    // MARK: - View & Image
    private let imageBackground = UIImageView()
    private let conteinerView = UIView()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        title = "Темы"
        view.backgroundColor = .clear
        imageBackground.image = UIImage(named: "space")
        imageBackground.contentMode = .scaleAspectFill
        imageBackground.translatesAutoresizingMaskIntoConstraints = false
        imageBackground.clipsToBounds = true
        view.addSubview(imageBackground)
    }
    
    private func setupSubviews() {
        // MARK: - View
        conteinerView.backgroundColor = UIColor(named: "blue")?.withAlphaComponent(0.7)
        conteinerView.layer.borderWidth = 0.5
        conteinerView.layer.cornerRadius = 10
        conteinerView.layer.borderColor = UIColor(named: "GravityColor")?.withAlphaComponent(0.5).cgColor
        conteinerView.layer.shadowColor = UIColor.white.cgColor
        conteinerView.layer.shadowOffset = .zero
        conteinerView.layer.shadowRadius = 3
        conteinerView.layer.shadowOpacity = 0.2
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(conteinerView)
        
        // MARK: - Labels
        label.text = "Смените обшивку вашего интерфейса. Переключайтесь между ослепительной энергией Светлой стороны и глубоким безмолвием Тёмного космоса в один клик"
        label.textColor = .white
        label.font = UIFont(name: "FunnelDisplay-Medium", size: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.addSubview(label)
        
        labelSystem.text = "Системнaя тема"
        labelDark.text = "Темная тема"
        [labelSystem, labelDark].forEach {
            $0.textColor = UIColor(named: "GravityColor")
            $0.font = UIFont(name: "FunnelDisplay-Bold", size: 25)
            $0.numberOfLines = 0
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // MARK: - Switch
        [systemSwitch, darkSwitch].forEach{
            $0.onTintColor = UIColor(named: "blue")
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        systemSwitch.addTarget(self, action: #selector(systemTheme), for: .valueChanged)
        darkSwitch.addTarget(self, action: #selector(darkTheme), for: .valueChanged)
        
        // MARK: - Stack
        systemStackView.axis = .horizontal
        systemStackView.spacing = 20
        systemStackView.alignment = .fill
        systemStackView.distribution = .fill
        systemStackView.translatesAutoresizingMaskIntoConstraints = false
        
        darkStackView.axis = .horizontal
        darkStackView.spacing = 20
        darkStackView.alignment = .fill
        darkStackView.distribution = .fill
        darkStackView.translatesAutoresizingMaskIntoConstraints = false
        
        systemStackView.addArrangedSubview(labelSystem)
        systemStackView.addArrangedSubview(systemSwitch)
        darkStackView.addArrangedSubview(labelDark)
        darkStackView.addArrangedSubview(darkSwitch)
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(systemStackView)
        stackView.addArrangedSubview(darkStackView)
        view.addSubview(stackView)
        
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            conteinerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            conteinerView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            conteinerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            conteinerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            label.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo:  conteinerView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            
        ])
    }
    
    // MARK: - Actions
    @objc private func systemTheme(_ sender: UISwitch){
        if sender.isOn{
            presenter?.selectedTheme(.system)
        } else {
            presenter?.selectedTheme(.dark)
        }
    }
    
    @objc private func darkTheme(_ sender: UISwitch){
        if sender.isOn{
            presenter?.selectedTheme(.dark)
        } else {
            presenter?.selectedTheme(.system)
        }
    }
}

// MARK: - Extensions
extension ThemeViewController: ThemeViewProtocol{
    func theme(isDarkOn: Bool, isSystemOn: Bool, selectedTheme: AppTheme) {
        systemSwitch.isOn = isSystemOn
        darkSwitch.isOn = isDarkOn
        
        let style: UIUserInterfaceStyle
        switch selectedTheme {
        case .dark:
            style = .dark
        case .system:
            style = .unspecified
        }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first{
            window.overrideUserInterfaceStyle = style
        }
    }
}

