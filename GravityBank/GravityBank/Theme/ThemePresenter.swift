//
//  ThemePresenter.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 31/05/2026.
//

import Foundation

final class ThemePresenter: ThemePresenterProtocol{
    
    weak var view: ThemeViewProtocol?
    
    func viewDidLoad() {
        let savedTheme = UserDefaults.standard.integer(forKey: "selectedTheme")
        if savedTheme == 0 {
            view?.theme(isDarkOn: false, isSystemOn: true, selectedTheme: .system)
        } else {
            view?.theme(isDarkOn: true, isSystemOn: false, selectedTheme: .dark)
        }
    }
    
    func selectedTheme(_ theme: AppTheme) {
        UserDefaults.standard.set(theme.rawValue, forKey: "selectedTheme")
        switch theme {
        case .dark:
            view?.theme(isDarkOn: true, isSystemOn: false, selectedTheme: .dark)
        case .system:
            view?.theme(isDarkOn: false, isSystemOn: true, selectedTheme: .system)
        }
    }
}



