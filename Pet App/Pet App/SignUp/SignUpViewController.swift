//
//  SignUpViewController.swift
//  Pet App
//
//  Created by Margarita Matsonko on 15/06/2026.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    private let viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    // MARK: - Labels
    private let nameLabel = UILabel()
    private let label = UILabel()
    private let loginLabel = UILabel()
    
    // MARK: - TextFields
   private let emailTextField = UITextField()
   private let passwordTextField = UITextField()
   private let confirmTextField = UITextField()
    
    // MARK: - Buttons
    private let logInButton = UIButton(type: .system)
    private let signUpButton = UIButton(type: .system)
    
    // MARK: - Scroll
    private let scrollView = UIScrollView()
    
    // MARK: - StackView
    private let verticalStackView = UIStackView()
    private let horizontalStackView = UIStackView()
    
    // MARK: - View & Image
    private let contentView = UIView()
    private let logo = UIImageView()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        bindViewModel()
    }
    
    // MARK: - Bindings
    
    private func bindViewModel(){
        viewModel.alertMessage.bind {[weak self] alert in
            guard let alert = alert else { return }
            self?.alert(title: alert.title, message: alert.message, success: alert.isSuccess)
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
        
        loginLabel.text = "Already have an account?"
        loginLabel.textColor = .darkBrown
        loginLabel.font = UIFont(name: "FunnelDisplay-Regular", size: 18)
        loginLabel.textAlignment = .center
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        confirmTextField.borderStyle = .roundedRect
        confirmTextField.attributedPlaceholder = NSAttributedString(
            string: "Confirm password",
            attributes: placeholderAttributes)
        addButton(textField: confirmTextField, iconName: "eye.slash")
        confirmTextField.textColor = .darkBrown
        confirmTextField.font = UIFont(name: "FunnelDisplay-Regular", size: 16)
        confirmTextField.isSecureTextEntry = true
        confirmTextField.backgroundColor = .lightText
        confirmTextField.clearButtonMode = .whileEditing
        confirmTextField.layer.borderColor = UIColor.border.cgColor
        confirmTextField.layer.borderWidth = 2
        confirmTextField.layer.cornerRadius = 10
        confirmTextField.clipsToBounds = true
        confirmTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmTextField.delegate = self
        
        // MARK: - Buttons
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "FunnelDisplay-Bold", size: 18)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = .darkBrown
        signUpButton.layer.cornerRadius = 15
        signUpButton.layer.borderColor = UIColor.secondaryBrown.cgColor
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.shadowColor = UIColor.border.withAlphaComponent(0.5).cgColor
        signUpButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        signUpButton.layer.shadowOpacity = 0.5
        signUpButton.layer.shadowRadius = 3
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        contentView.addSubview(signUpButton)
        
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.darkBrown, for: .normal)
        logInButton.titleLabel?.font = UIFont(name: "FunnelDisplay-Bold", size: 18)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        
        // MARK: - StackView
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 16
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        [emailTextField, passwordTextField, confirmTextField].forEach{
            verticalStackView.addArrangedSubview($0)
        }
        contentView.addSubview(verticalStackView)
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 5
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fill
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        [loginLabel, logInButton].forEach{
            horizontalStackView.addArrangedSubview($0)
        }
        contentView.addSubview(horizontalStackView)
    }
    
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
            confirmTextField.heightAnchor.constraint(equalToConstant: 50),
            
            horizontalStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 30),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 25),
            signUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            signUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    //    MARK: - Actions
    
    @objc private func keyboardWillShow( notification: NSNotification){
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            scrollView.contentInset.bottom = keyboardHeight
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
            scrollView.isScrollEnabled = true
            animateLayout(notification: notification)
        }
    }
    
    @objc private func keyboardWillHide( notification: NSNotification){
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
    
    private func alert(title: String, message: String, success: Bool){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default){[weak self] _ in
            if success{
                self?.viewModel.logInAction()
            }
        })
        self.present(alert, animated: true)
    }
    
    @objc private func signUpButtonTapped(){
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmTextField.text ?? ""
        
       viewModel.signUp(email: email, password: password, confirmPassword: confirmPassword)
        
    }
    
    @objc private func logInButtonTapped(){
       viewModel.logInAction()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Extensions
extension SignUpViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.darkBrown.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
    }
}
