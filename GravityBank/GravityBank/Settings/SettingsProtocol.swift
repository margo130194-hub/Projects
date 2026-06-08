//
//  SettingsProtocol.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 30/05/2026.
//

import Foundation

protocol SettingsViewProtocol: AnyObject{
    func showAlert(title: String, message: String)
}

protocol SettingsRouterProtocol: AnyObject{
    func navigateToLogin()
}

protocol SettingsPresenterProtocol: AnyObject{
    func deleteFromKeychain(account: String)
    func currentUser() -> String?
    func logOut()
}
