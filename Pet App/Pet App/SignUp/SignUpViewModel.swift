//
//  SignUpViewModel.swift
//  Pet App
//
//  Created by Margarita Matsonko on 19/06/2026.
//

import UIKit
import FirebaseCore
import FirebaseAuth

final class SignUpViewModel{
    
    struct SignUpAlert{
        let title: String
        let message: String
        let isSuccess: Bool
    }
    
    private weak var coordinator: SignUpCoordinator?
    
    let alertMessage = Bindable<SignUpAlert?>(nil)
        
    init(coordinator: SignUpCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func signUp(email: String, password: String, confirmPassword: String) {
        
        guard !email.isEmpty else {
            alertMessage.value = SignUpAlert(
                title: "⚠️",
                message: "Please enter your email address.",
                isSuccess: false)
        
            return
        }
        
        guard Validator.isValidEmail(email) else {
            alertMessage.value = SignUpAlert(
                title: "⚠️",
                message: "Please enter a valid email address.",
                isSuccess: false)
            return
        }
        
        guard !password.isEmpty else {
            alertMessage.value = SignUpAlert(
                title: "⚠️",
                message: "Please enter your password",
                isSuccess: false)
            return
        }
        
        guard Validator.isValidPassword(password) else {
            alertMessage.value = SignUpAlert(
                title: "⚠️",
                message: "Password must contain at least 6 characters",
                isSuccess: false)
            return
        }
        
        guard !confirmPassword.isEmpty else {
            alertMessage.value = SignUpAlert(
                title: "⚠️",
                message: "Please confirm your password",
                isSuccess: false)
            return
        }
        
        guard password == confirmPassword else {
            alertMessage.value = SignUpAlert(
                title: "⚠️",
                message: "Passwords do not match",
                isSuccess: false)
            return
        }
        
        Task{ [weak self] in
            do{
                print("Before Firebase signIn")
               try await Auth.auth().createUser(withEmail: email, password: password)
                print("After Firebase signIn")
                await MainActor.run{
                    self?.alertMessage.value = SignUpAlert(
                        title: "✅",
                        message: "Account successfully created!",
                        isSuccess: true)
                }
            }
            catch{
                print("Firebase error:", error.localizedDescription)
                await MainActor.run{
                    self?.alertMessage.value = SignUpAlert(
                        title: "⚠️",
                        message: error.localizedDescription,
                        isSuccess: false)
                }
            }
        }
    }
    
    func logInAction() {
        coordinator?.navigateToLogIn()
    }
}
