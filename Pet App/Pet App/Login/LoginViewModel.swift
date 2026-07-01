//
//  LoginViewModel.swift
//  Pet App
//
//  Created by Margarita Matsonko on 15/06/2026.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

final class LoginViewModel{
    
    weak var coordinator: LoginCoordinator?
    
    let errorMessage = Bindable<String>("")
        
    init(coordinator: LoginCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func logIn(email: String, password: String) {
        guard !email.isEmpty else {
            errorMessage.value = "Please enter your email address."
            return
        }
        
        guard Validator.isValidEmail(email) else {
            errorMessage.value = "Please enter a valid email address."
            return
        }
        guard !password.isEmpty else {
            errorMessage.value = "Please enter your password"
            return
        }
        
        guard Validator.isValidPassword(password) else {
            errorMessage.value = "Password must contain at least 6 characters"
            return
        }
        
        Task{ [weak self] in
            do{
                try await Auth.auth().signIn(withEmail: email, password: password)
                await MainActor.run{
                    self?.coordinator?.navigateToMainView()
                }
            }
            catch{
                await MainActor.run{
                    self?.errorMessage.value = error.localizedDescription
                }
            }
        }
    }
    
    func googleSignIn(withPresenting viewController: UIViewController){
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { [weak self] result, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    self?.errorMessage.value = "Something went wrong"
                }
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                DispatchQueue.main.async {
                    self?.errorMessage.value = "Something went wrong"
                }
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            self?.signInWithCredential(credential)
        }
    }
    
    private func signInWithCredential(_ credential: AuthCredential){
        Task{ [weak self] in
            do{
                try await Auth.auth().signIn(with: credential)
                await MainActor.run{
                    self?.coordinator?.navigateToMainView()
                }
            }
            catch{
                await MainActor.run{
                    self?.errorMessage.value =  error.localizedDescription
                }
            }
        }
    }
    
    func signUpAction() {
        coordinator?.navigateToSignUp()
    }
    
    func passwordReset() {
        coordinator?.navigateToReset()
    }
}
