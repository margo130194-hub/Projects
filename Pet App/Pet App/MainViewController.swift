//
//  MainViewController.swift
//  Pet Advisor
//
//  Created by Margarita Matsonko on 08/06/2026.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Subviews
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .beige
    }
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
        ])
    }
    
}

