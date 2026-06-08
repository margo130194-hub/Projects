//
//  SettingsPresenter.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 30/05/2026.
//

import Foundation
import Security

final class SettingsPresenter: SettingsPresenterProtocol{
    
    weak var view: SettingsViewProtocol?
    var router: SettingsRouterProtocol?
    private let keychainService = "co.margarita.GravityBank"
    
    func deleteFromKeychain(account: String) {
        let query: [String: Any] = [
            kSecClass as String:       kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: account
        ]
        let status = SecItemDelete(query as CFDictionary)
        switch status {
        case errSecSuccess:
            view?.showAlert(title: "⚠️", message: "Аккаунт удален")
        case errSecItemNotFound:
            view?.showAlert(title: "⚠️", message: "Аккаунт не найден")
        default:
            view?.showAlert(title: "⚠️", message: "Произошла ошибка. Попробуйте еще раз")
        }
    }
    
    func currentUser() -> String? {
        let query: [String: Any] = [
            kSecClass as String:             kSecClassGenericPassword,
            kSecAttrService as String:       keychainService,
            kSecReturnAttributes as String:  true,
            kSecMatchLimit as String:        kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let userData = result as? [String: Any]{
            if let currentAccount = userData[kSecAttrAccount as String] as? String{
                return currentAccount
            }
        }
        return nil
    }
    
    func logOut() {
        guard let currentAccount = currentUser() else {return}
        deleteFromKeychain(account: currentAccount)
        router?.navigateToLogin()
    }
}
