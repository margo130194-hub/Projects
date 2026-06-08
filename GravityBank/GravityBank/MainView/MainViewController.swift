//
//  MainViewController.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 04/04/2026.
//
import UIKit

final class MainViewController: UIViewController {
    
    static func build() -> UIViewController{
        let vc = MainViewController()
        let presenter = MainPresenter()
        
        vc.presenter = presenter
        presenter.view = vc
        
        return vc
    }
    
    var presenter: MainPresenterProtocol?
    
    // MARK: - Subviews
    private let greetingLabel = UILabel()
    private let table = UITableView()
    private var deposit: [Deposit] = []
    private let imageBackground = UIImageView()
    
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
        view.backgroundColor = .clear
        imageBackground.image = UIImage(named: "space")
        imageBackground.contentMode = .scaleAspectFill
        imageBackground.translatesAutoresizingMaskIntoConstraints = false
        imageBackground.clipsToBounds = true
        view.addSubview(imageBackground)
    }
    
    private func setupSubviews() {
        greetingLabel.font = UIFont(name: "FunnelDisplay-Bold", size: 27)
        greetingLabel.textColor = UIColor(named: "GravityColor")
        greetingLabel.numberOfLines = 0
        greetingLabel.textAlignment = .center
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(greetingLabel)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.rowHeight = 300
        table.allowsSelection = false
        table.backgroundColor = .clear
        table.delegate = self
        table.dataSource = self
        table.register(TableCell.self, forCellReuseIdentifier: "TableCell")
        view.addSubview(table)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            greetingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            greetingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            table.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 20),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
// MARK: - Extensions

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deposit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableCell else {
            return UITableViewCell()
        }
        let deposit = deposit[indexPath.row]
        cell.configure(with: deposit, index: indexPath.row)
        return cell
    }
}

extension MainViewController: MainViewProtocol{
    func showDeposit(_ deposits: [Deposit]) {
        self.deposit = deposits
        table.reloadData()
    }
    
    func showGreetings(text: String) {
        greetingLabel.text = text
    }
}
