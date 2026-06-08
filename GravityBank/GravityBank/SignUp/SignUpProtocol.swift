//
//  SignUpProtocol.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 29/05/2026.
//

import Foundation

protocol SignUpViewProtocol: AnyObject{
    func showAlert(title: String, message: String, isSuccess: Bool)
}

protocol SignUpPresenterProtocol: AnyObject{
    func newAccount(number: String, password: String, name: String)
    func goToLogin()
}

protocol SignUpRouterProtocol: AnyObject{
    func navigateToLogin()
    
}
