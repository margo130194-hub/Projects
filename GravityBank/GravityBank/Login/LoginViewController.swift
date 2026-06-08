//
//  ViewController.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 02/04/2026.
//

import UIKit

final class LoginViewController: UIViewController {
    
    static func build() -> UIViewController{
        let vc = LoginViewController()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        
        vc.presenter = presenter
        presenter.router = router
        presenter.view = vc
        router.viewController = vc
        
        return vc
    }
    
    var presenter: LoginPresenterProtocol?
    
    // MARK: - Labels
    private let label = UILabel()
    private let signUpLabel = UILabel()
    
    // MARK: - Buttons
    private let logIn = UIButton(type: .system)
    private let signUp = UIButton(type: .system)
    private let forgotPassword = UIButton(type: .system)
    
    // MARK: - TextFields
    private let number = UITextField()
    private let password = UITextField()
    
    // MARK: - Images & View
    private let image = UIImageView()
    private let imageBackground = UIImageView()
    private let contentView = UIView()
    
    // MARK: - Stack & Scroll
    private let stackView = UIStackView()
    private let horizontalStackView = UIStackView()
    private let scrollView = UIScrollView()
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        presenter?.viewDidLoad()
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
        imageBackground.alpha = 0.4
        imageBackground.contentMode = .scaleToFill
        imageBackground.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        view.addSubview(imageBackground)
        view.sendSubviewToBack(imageBackground)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func setupSubviews() {
        
        // MARK: - Image
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray.withAlphaComponent(0.8),
            .font: UIFont(name: "FunnelDisplay-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15)
        ]
        image.image = UIImage(named: "saturn")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        
        // MARK: - Labels
        label.text = "Gravity Bank"
        label.font = UIFont(name: "FunnelDisplay-Bold", size: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        signUpLabel.text = "Создать новый аккаунт?"
        signUpLabel.textColor = .white
        signUpLabel.font = UIFont(name: "FunnelDisplay-Medium", size: 18)
        signUpLabel.textAlignment = .center
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - TextFields
        [number, password].forEach{
            $0.borderStyle = .roundedRect
            $0.clearButtonMode = .whileEditing
            $0.delegate = self
            $0.textColor = .black
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        number.keyboardType = .phonePad
        password.attributedPlaceholder = NSAttributedString(
            string: "Пароль",
            attributes: placeholderAttributes)
        number.attributedPlaceholder = NSAttributedString(
            string: "Номер телефона: 123 456 789",
            attributes: placeholderAttributes)
        password.isSecureTextEntry = true
        addButton(textField: password, iconName: "eye.slash")
        
        // MARK: - Stack
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(number)
        stackView.addArrangedSubview(password)
        contentView.addSubview(stackView)
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 5
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fill
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        [signUpLabel, signUp].forEach{
            horizontalStackView.addArrangedSubview($0)
        }
        contentView.addSubview(horizontalStackView)
        
        // MARK: - Buttons
        logIn.setTitle("Войти", for: .normal)
        logIn.setTitleColor(.white, for: .normal)
        logIn.titleLabel?.font = UIFont(name: "FunnelDisplay-Bold", size: 18)
        logIn.backgroundColor = .black
        logIn.layer.cornerRadius = 10
        logIn.layer.borderColor = UIColor.white.cgColor
        logIn.layer.borderWidth = 1
        logIn.layer.shadowColor = UIColor.white.withAlphaComponent(1).cgColor
        logIn.layer.shadowOffset = CGSize(width: 0, height: 2)
        logIn.layer.shadowOpacity = 0.8
        logIn.layer.shadowRadius = 3
        logIn.translatesAutoresizingMaskIntoConstraints = false
        logIn.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)
        contentView.addSubview(logIn)
        
        signUp.setTitle("Регистрация", for: .normal)
        signUp.setTitleColor(.white, for: .normal)
        signUp.titleLabel?.font = UIFont(name: "FunnelDisplay-Bold", size: 18)
        signUp.translatesAutoresizingMaskIntoConstraints = false
        signUp.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        
        forgotPassword.setTitle("Забыли пароль?", for: .normal)
        forgotPassword.setTitleColor(.white, for: .normal)
        forgotPassword.titleLabel?.font = UIFont(name: "FunnelDisplay-Regular", size: 15)
        forgotPassword.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(forgotPassword)
    }
    
    //    MARK: - Conctraints
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
            image.widthAnchor.constraint(equalToConstant: 130),
            image.heightAnchor.constraint(equalToConstant: 130),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            forgotPassword.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            forgotPassword.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            logIn.topAnchor.constraint(equalTo: forgotPassword.bottomAnchor, constant: 25),
            logIn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            logIn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            logIn.heightAnchor.constraint(equalToConstant: 50),
            
            horizontalStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: logIn.bottomAnchor, constant: 30),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    //    MARK: - Actions
    
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
    
    private func addButton(textField: UITextField, iconName: String){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 40))
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: iconName)
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        config.imageColorTransformer = UIConfigurationColorTransformer{ _ in
            return .black
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
    
    @objc private func logInTapped(){
        let number = number.text ?? ""
        let password = password.text ?? ""
        
        presenter?.logInTapped(number: number, password: password)
    }
    
    private func alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    @objc private func signUpAction(){
        presenter?.signUpAction()
    }
}

//MARK: - Extensions

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.black.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
}

extension LoginViewController: LoginViewProtocol{
    func showSavedNumber(_ number: String) {
        self.number.text = number
    }
    
    func showAlert(title: String, message: String) {
        self.alert(title: title, message: message)
    }
}

//#Preview{
//    LoginViewController()
//}
