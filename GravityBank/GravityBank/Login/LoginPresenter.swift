//
//  LoginPresenter.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 24/05/2026.
//

import Foundation
import Security

final class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginViewProtocol?
    var router: LoginRouterProtocol?
    private let keychainService = "co.margarita.GravityBank"
    
    func logInTapped(number: String, password: String) {
        guard !number.isEmpty else {
            view?.showAlert(title: "⚠️", message: "Введите номер")
            return
        }
        guard !password.isEmpty else {
            view?.showAlert(title: "⚠️", message: "Введите пароль")
            return
        }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: number,
            kSecReturnData as String:  true,
            kSecMatchLimit as String:  kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        switch status {
        case errSecSuccess:
            if let data = result as? Data,
               let savedPassword = String(data: data, encoding: .utf8) {
                if savedPassword == password{
                    UserDefaults.standard.set(number, forKey: "userNumber")
                    router?.navigateToMainView()
                }
            } else {
                view?.showAlert(title: "⚠️", message: "Неверный пароль!")
            }
        case errSecItemNotFound:
            view?.showAlert(title: "⚠️", message: "Пользователь не найден. Пожалуйста зарегистрируйтесь")
        default:
            view?.showAlert(title: "⚠️", message: "Произошла ошибка. Попробуйте еще раз")
        }
    }
    
    func viewDidLoad() {
        if let savedNumber = UserDefaults.standard.string(forKey: "userNumber"){
            view?.showSavedNumber(savedNumber)
        }
    }
    
    func signUpAction() {
        router?.navigateToSignUp()
    }
}
