//
//  ThemeProtocol.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 31/05/2026.
//

import Foundation

protocol ThemePresenterProtocol: AnyObject{
    func viewDidLoad()
    func selectedTheme(_ theme: AppTheme)
}

protocol ThemeViewProtocol: AnyObject{
    func theme(isDarkOn: Bool, isSystemOn: Bool, selectedTheme: AppTheme)
}
