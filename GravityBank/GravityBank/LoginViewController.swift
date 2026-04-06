//
//  ViewController.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 02/04/2026.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Subviews
    private let number = UITextField()
    private let labelNumber = UILabel()
    private let password = UITextField()
    private let labelPassword = UILabel()
    private let label = UILabel()
    private let logIn = UIButton(type: .system)
    private let signIn = UIButton(type: .system)
    private let forgotPassword = UIButton(type: .system)
    private let image = UIImageView()
    private let imageBackground = UIImageView()
    private let stackView = UIStackView()
    private let buttonStackView = UIStackView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - Layout
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    private func setupViewProperties(){
        imageBackground.image = UIImage(named: "space")
        imageBackground.contentMode = .scaleToFill
        imageBackground.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        view.addSubview(imageBackground)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func setupSubviews() {
        image.image = UIImage(named: "saturn")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        
        label.text = "Gravity Bank"
        label.font = UIFont(name: "PlayfairDisplay-Bold", size: 50)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        labelNumber.text = "Phone number"
        labelPassword.text = "Password"
        [labelNumber, labelPassword].forEach{
            $0.font = .systemFont(ofSize: 25, weight: .medium)
            $0.textColor = .white
            $0.textAlignment = .left
            $0.translatesAutoresizingMaskIntoConstraints = false
            }
        
        [number, password].forEach{
            $0.borderStyle = .roundedRect
            $0.clearButtonMode = .whileEditing
            $0.delegate = self
            $0.textColor = .black
            $0.backgroundColor = .white
            $0.widthAnchor.constraint(equalToConstant: 260).isActive = true
            $0.translatesAutoresizingMaskIntoConstraints = false
            
        }
        number.keyboardType = .phonePad
        password.isSecureTextEntry = true
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(labelNumber)
        stackView.addArrangedSubview(number)
        stackView.addArrangedSubview(labelPassword)
        stackView.addArrangedSubview(password)
        contentView.addSubview(stackView)
        
        [logIn, signIn, forgotPassword].forEach{
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 1
            $0.layer.shadowColor = UIColor.white.withAlphaComponent(1).cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: 2)
            $0.layer.shadowOpacity = 0.8
            $0.layer.shadowRadius = 3
            $0.translatesAutoresizingMaskIntoConstraints = false
            buttonStackView.addArrangedSubview($0)
        }
        
        logIn.setTitle("Log In", for: .normal)
        signIn.setTitle("Sign In", for: .normal)
        forgotPassword.setTitle("Forgot password?", for: .normal)
        
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 25
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fill
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonStackView)
        logIn.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            image.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 150),
            image.heightAnchor.constraint(equalToConstant: 150),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            
            buttonStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            buttonStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonStackView.widthAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    @objc private func keyboardWillShow( notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            scrollView.contentInset.bottom = keyboardHeight
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
            animateLayout(notification: notification)
        }
    }
    @objc private func keyboardWillHide( notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
        animateLayout(notification: notification)
    }
    
    private func  animateLayout( notification: NSNotification){
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.3
        UIView.animate(withDuration: duration){
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func logInTapped(){
        if number.text == "555",
           password.text == "000"{
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            guard let window = view.window else { return }
            window.rootViewController = TabBarViewController()
        } else {
            let alert = UIAlertController(
                title: "ERROR",
                message: "Please try again",
                preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "OK", style: .destructive)
            
            alert.addAction(closeAction)
            self.present(alert, animated: true)
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.black.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
}

//#Preview{
//    LoginViewController()
//}
