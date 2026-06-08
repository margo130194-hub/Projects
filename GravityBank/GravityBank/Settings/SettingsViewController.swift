//
//  SettingsViewController.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 04/04/2026.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    static func build() -> UIViewController{
        let vc = SettingsViewController()
        let presenter = SettingsPresenter()
        let router = SettingsRouter()
        
        vc.presenter = presenter
        presenter.router = router
        presenter.view = vc
        router.viewController = vc
        
        return vc
    }
    
    var presenter: SettingsPresenterProtocol?
    
    // MARK: - Subviews
    private let imageBackground = UIImageView()
    private let table = UITableView()
    private var groups = [
        SettingsModel(name: "Тема"),
        SettingsModel(name: "Уведомления")
        
    ]
    private let logOut = UIButton(type: .system)
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .clear
        imageBackground.image = UIImage(named: "space")
        imageBackground.contentMode = .scaleAspectFill
        imageBackground.translatesAutoresizingMaskIntoConstraints = false
        imageBackground.clipsToBounds = true
        view.addSubview(imageBackground)
    }
    
    private func setupSubviews() {
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.rowHeight = 100
        table.backgroundColor = .clear
        table.delegate = self
        table.dataSource = self
        table.register(SettingCell.self, forCellReuseIdentifier: "SettingCell")
        view.addSubview(table)
        
        logOut.setTitle("Выйти", for: .normal)
        logOut.setTitleColor(UIColor(named: "GravityColor"), for: .normal)
        logOut.titleLabel?.font = UIFont(name: "FunnelDisplay-Regular", size: 25)
        logOut.translatesAutoresizingMaskIntoConstraints = false
        logOut.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
        view.addSubview(logOut)
    }
    
    //    MARK: - Conctraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            logOut.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logOut.topAnchor.constraint(equalTo: table.bottomAnchor, constant: 30),
            logOut.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    //    MARK: - Actions
    @objc private func logOutAction(){
        presenter?.logOut()
    }
    
    private func alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

//    MARK: - Extensions
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as? SettingCell else {
            return UITableViewCell()
        }
        let groups = groups[indexPath.row]
        cell.configure(with: groups, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc = ThemeViewController.build()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = NotificationViewController.build()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

extension SettingsViewController: SettingsViewProtocol{
    func showAlert(title: String, message: String) {
        self.alert(title: title, message: message)
    }
}
