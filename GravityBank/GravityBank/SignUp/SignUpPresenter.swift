//
//  File.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 29/05/2026.
//

import Foundation
import Security

final class SignUpPresenter: SignUpPresenterProtocol {
    
    weak var view: SignUpViewProtocol?
    var router: SignUpRouterProtocol?
    
    private let keychainService = "co.margarita.GravityBank"
    func newAccount(number: String, password: String, name: String) {
        let cleanNumber = number.filter{$0.isNumber}
        guard cleanNumber.count == 9 else {
            view?.showAlert(title: "⚠️", message: "Номер телефона некорректный", isSuccess: false)
            return
        }
        let specificKey = "userName \(cleanNumber)"
        guard !name.isEmpty else {
            view?.showAlert(title: "⚠️", message: "Введите имя", isSuccess: false)
            return
        }
        guard !cleanNumber.isEmpty else {
            view?.showAlert(title: "⚠️", message: "Введите номер", isSuccess: false)
            return
        }
        guard !password.isEmpty else{
            view?.showAlert(title: "⚠️", message: "Введите пароль", isSuccess: false)
            return
        }
        guard let passwordData = password.data(using: .utf8) else {return}
        
        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: cleanNumber
        ]
        SecItemDelete(deleteQuery as CFDictionary)
        print("delete")
        let addQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: cleanNumber,
            kSecValueData as String: passwordData
        ]
        print("add")
        let status = SecItemAdd(addQuery as CFDictionary, nil)
        print("проверка статуса")
        if status == errSecSuccess {
            print("\(status)")
            UserDefaults.standard.set(name, forKey: specificKey)
            view?.showAlert(title: "Ура", message: "Данные успешно сохранены. Теперь можно войти в приложение", isSuccess: true)
        } else {
            print("\(status)")
            view?.showAlert(title: "Упс", message: "Ошибка сохранения. Попробуйте еще раз", isSuccess: false)
        }
    }
    
    func goToLogin() {
        router?.navigateToLogin()
    }
}
