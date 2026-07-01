//
//  LoginViewController.swift
//  Pet App
//
//  Created by Margarita Matsonko on 15/06/2026.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     // MARK: - Labels
     private let nameLabel = UILabel()
     private let label = UILabel()
     private let signUpLabel = UILabel()
     private let optionsLabel = UILabel()
     
     // MARK: - TextFields
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    
    // MARK: - Buttons
    private let logInButton = UIButton(type: .system)
    private let forgotButton = UIButton(type: .system)
    private let buttonSignUp = UIButton(type: .system)
    
    // MARK: - Scroll
    private let scrollView = UIScrollView()
    
    // MARK: - StackView
    private let verticalStackView = UIStackView()
    private let horizontalStackView = UIStackView()
    private let viewStackView = UIStackView()
    private let buttonStackView = UIStackView()
    
    // MARK: - View & Image
    private let contentView = UIView()
    private let leftView = UIView()
    private let rightView = UIView()
    private let logo = UIImageView()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        bindViewModel()
    }
    
    // MARK: - Bindings
    
    private func bindViewModel(){
        viewModel.errorMessage.bind {[weak self] message in
            guard !message.isEmpty else { return }
            self?.alert(title: "⚠️", message: message)
        }
    }
    // MARK: - Layout
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    private func setupViewProperties() {
        view.backgroundColor = UIColor(named: "beige")
        scrollView.alwaysBounceVertical = false
        scrollView.isScrollEnabled = false
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func setupSubviews() {
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkBrown.withAlphaComponent(0.7),
            .font: UIFont(name: "FunnelDisplay-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)
            ]
        
        logo.image = UIImage(named: "pet")
        logo.contentMode = .scaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(logo)
        
        // MARK: - Labels
        nameLabel.text = "Pet Advisor"
        nameLabel.textColor = UIColor(named: "darkBrown")
        nameLabel.font = UIFont(name: "FunnelDisplay-Bold", size: 30)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        label.text = "Your smart guide to a happy life together"
        label.textColor = UIColor(named: "darkBrown")
        label.font = UIFont(name: "FunnelDisplay-Regular", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        signUpLabel.text = "Don't have an account?"
        signUpLabel.textColor = .darkBrown
        signUpLabel.font = UIFont(name: "FunnelDisplay-Regular", size: 18)
        signUpLabel.textAlignment = .center
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        optionsLabel.text = "or"
        optionsLabel.textAlignment = .center
        optionsLabel.textColor = .secondaryBrown.withAlphaComponent(0.6)
        optionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - TextFields
        emailTextField.borderStyle = .roundedRect
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: placeholderAttributes)
        emailTextField.clipsToBounds = true
        emailTextField.textColor = .darkBrown
        emailTextField.font = UIFont(name: "FunnelDisplay-Regular", size: 16)
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.backgroundColor = .lightText
        emailTextField.clearButtonMode = .whileEditing
        emailTextField.layer.borderColor = UIColor.border.cgColor
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.cornerRadius = 10
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.delegate = self
        
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: placeholderAttributes)
        addButton(textField: passwordTextField, iconName: "eye.slash")
        passwordTextField.textColor = .darkBrown
        passwordTextField.font = UIFont(name: "FunnelDisplay-Regular", size: 16)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .lightText
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.layer.borderColor = UIColor.border.cgColor
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.clipsToBounds = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.delegate = self
        
        // MARK: - Buttons
        logInButton.setTitle("Log In", for: .normal)
        logInButton.titleLabel?.font = UIFont(name: "FunnelDisplay-Bold", size: 18)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.backgroundColor = .darkBrown
        logInButton.layer.cornerRadius = 15
        logInButton.layer.borderColor = UIColor.secondaryBrown.cgColor
        logInButton.layer.borderWidth = 1
        logInButton.layer.shadowColor = UIColor.border.withAlphaComponent(0.5).cgColor
        logInButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        logInButton.layer.shadowOpacity = 0.5
        logInButton.layer.shadowRadius = 3
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        contentView.addSubview(logInButton)
        
        forgotButton.setTitle("Forgot password?", for: .normal)
        forgotButton.setTitleColor(.secondaryBrown, for: .normal)
        forgotButton.titleLabel?.font = UIFont(name: "FunnelDisplay-Regular", size: 15)
        forgotButton.translatesAutoresizingMaskIntoConstraints = false
        forgotButton.addTarget(self, action: #selector(passwordReset), for: .touchUpInside)
        contentView.addSubview(forgotButton)
        
        buttonSignUp.setTitle("Sign Up", for: .normal)
        buttonSignUp.setTitleColor(.darkBrown, for: .normal)
        buttonSignUp.titleLabel?.font = UIFont(name: "FunnelDisplay-Bold", size: 18)
        buttonSignUp.translatesAutoresizingMaskIntoConstraints = false
        buttonSignUp.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        let googleButton = createButton(title: "Continue with Google", iconName: "google")
        googleButton.addTarget(self, action: #selector(googleSignIn), for: .touchUpInside)
        let appleButton = createButton(title: "Continue with Apple", iconName: "apple")
        [googleButton, appleButton].forEach{ button in
            var config = button.configuration ?? UIButton.Configuration.plain()
            var container = AttributeContainer()
            container.font = UIFont(name: "FunnelDisplay-Medium", size: 16)
            config.attributedTitle = AttributedString(config.title ?? "", attributes: container)
            config.background.backgroundColor = .lightText
            button.configuration = config
            
            
            button.layer.borderColor = UIColor.border.cgColor
            button.layer.borderWidth = 2
            button.layer.shadowColor = UIColor.darkBrown.withAlphaComponent(0.5).cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.5
            button.layer.shadowRadius = 3
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            buttonStackView.addArrangedSubview(button)
        }
        
        // MARK: - StackView
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 16
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        [emailTextField, passwordTextField].forEach{
            verticalStackView.addArrangedSubview($0)
        }
        contentView.addSubview(verticalStackView)
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 5
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fill
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        [signUpLabel, buttonSignUp].forEach{
            horizontalStackView.addArrangedSubview($0)
        }
        contentView.addSubview(horizontalStackView)
        
        viewStackView.axis = .horizontal
        viewStackView.spacing = 10
        viewStackView.alignment = .center
        viewStackView.distribution = .fillEqually
        viewStackView.translatesAutoresizingMaskIntoConstraints = false
        viewStackView.addArrangedSubview(leftView)
        viewStackView.addArrangedSubview(optionsLabel)
        viewStackView.addArrangedSubview(rightView)
        contentView.addSubview(viewStackView)
        
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 16
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fill
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonStackView)
        
        // MARK: - View
        leftView.backgroundColor = .secondaryBrown.withAlphaComponent(0.6)
        leftView.translatesAutoresizingMaskIntoConstraints = false
        
        rightView.backgroundColor = .secondaryBrown.withAlphaComponent(0.6)
        rightView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            logo.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            logo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 120),
            logo.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            label.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 13),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            verticalStackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 35),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            forgotButton.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 5),
            forgotButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            logInButton.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: 25),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            logInButton.heightAnchor.constraint(equalToConstant: 50),

            horizontalStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 30),
            
            viewStackView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 10),
            viewStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            viewStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            rightView.heightAnchor.constraint(equalToConstant: 1),
            leftView.heightAnchor.constraint(equalToConstant: 1),
        
            buttonStackView.topAnchor.constraint(equalTo: viewStackView.bottomAnchor, constant: 10),
            buttonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            buttonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            buttonStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
        ])
    }
    
    // MARK: - Actions
    @objc private func keyboardWillShow( notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            scrollView.contentInset.bottom = keyboardHeight
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
            scrollView.isScrollEnabled = true
            animateLayout(notification: notification)
        }
    }
    
    @objc private func keyboardWillHide( notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
        scrollView.setContentOffset(CGPoint(x: 0, y: -scrollView.safeAreaInsets.top), animated: true)
        scrollView.isScrollEnabled = false
        animateLayout(notification: notification)
    }
    
    private func  animateLayout( notification: NSNotification){
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.3
        UIView.animate(withDuration: duration){
            self.view.layoutIfNeeded()
        }
    }
    
    private func addButton(textField: UITextField, iconName: String){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 40))
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: iconName)
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        config.imageColorTransformer = UIConfigurationColorTransformer{ _ in
            return .secondaryBrown
        }
        let eyeButton = UIButton(configuration: config)
        eyeButton.frame = view.bounds
        eyeButton.center = view.center
        eyeButton.addTarget(self, action: #selector(eyeToggle), for: .touchUpInside)
        view.addSubview(eyeButton)

        textField.rightView = view
        textField.rightViewMode = .always
        }
    
    @objc private func eyeToggle(_ sender: UIButton){
        guard let textField = sender.superview?.superview as? UITextField else {return}
        
        textField.isSecureTextEntry.toggle()
        
        let iconName = textField.isSecureTextEntry ? "eye.slash" : "eye"
        
        var config = sender.configuration
        config?.image = UIImage(systemName: iconName)
        
        UIView.transition(with: sender, duration: 0.2, options: .transitionCrossDissolve){
            sender.configuration = config
        }
    }
    
    private func createButton( title: String, iconName: String, placement: NSDirectionalRectEdge = .all) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.title = title
        config.baseForegroundColor = .darkBrown
        
        if let image = UIImage(named: iconName){
            let size = CGSize(width: 20, height: 20)
            config.image = image.preparingThumbnail(of: size)
        }
        
        config.imagePlacement = placement
        config.imagePadding = 10
       
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        let button = UIButton(configuration: config)
        return button
    }
    
    private func alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    @objc private func logIn(){
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        viewModel.logIn(email: email, password: password)
    }
    
    @objc private func signUp(){
        viewModel.signUpAction()
    }
    
    @objc private func passwordReset(){
       viewModel.passwordReset()
    }
    
    @objc private func googleSignIn(){
        viewModel.googleSignIn(withPresenting: self)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    }
    
// MARK: - Extensions
extension LoginViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.darkBrown.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
    }
}
