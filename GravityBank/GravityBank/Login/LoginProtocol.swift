//
//  LoginProtocol.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 25/05/2026.
//

import Foundation

protocol LoginViewProtocol: AnyObject {
    func showAlert(title: String, message: String)
    func showSavedNumber(_ number: String)
}

protocol LoginPresenterProtocol: AnyObject {
    func viewDidLoad()
    func logInTapped(number: String, password: String)
    func signUpAction()
}

protocol LoginRouterProtocol: AnyObject{
    func navigateToMainView()
    func navigateToSignUp()
}
