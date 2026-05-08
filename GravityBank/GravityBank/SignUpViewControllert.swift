//
//  SignUpViewControllert.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 03/05/2026.
//


import UIKit
import Security

final class SignUpViewController: UIViewController {
    
    // MARK: - Subviews
    private let keychainService = "co.margarita.GravityBank"
    private let number = UITextField()
    private let password = UITextField()
    private let name = UITextField()
    private let label = UILabel()
    private let signUp = UIButton(type: .system)
    private let image = UIImageView()
    private let imageBackground = UIImageView()
    private let stackView = UIStackView()
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
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray.withAlphaComponent(0.8),
            .font: UIFont(name: "FunnelDisplay-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15)
        ]
        image.image = UIImage(named: "saturn")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        
        label.text = "Gravity Bank"
        label.font = UIFont(name: "FunnelDisplay-Bold", size: 45)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        [number, password, name].forEach{
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
        name.attributedPlaceholder = NSAttributedString(
            string: "Имя пользователя",
            attributes: placeholderAttributes)
        password.isSecureTextEntry = true
        addButton(textField: password, iconName: "eye.slash")
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(number)
        stackView.addArrangedSubview(password)
        contentView.addSubview(stackView)
        
        signUp.setTitle("Зарегистрироваться", for: .normal)
        signUp.setTitleColor(.white, for: .normal)
        signUp.titleLabel?.font = UIFont(name: "FunnelDisplay-Bold", size: 20)
        signUp.backgroundColor = .black
        signUp.layer.cornerRadius = 10
        signUp.layer.borderColor = UIColor.white.cgColor
        signUp.layer.borderWidth = 1
        signUp.layer.shadowColor = UIColor.white.withAlphaComponent(1).cgColor
        signUp.layer.shadowOffset = CGSize(width: 0, height: 2)
        signUp.layer.shadowOpacity = 0.8
        signUp.layer.shadowRadius = 3
        signUp.translatesAutoresizingMaskIntoConstraints = false
        signUp.addTarget(self, action: #selector(newAccountAction), for: .touchUpInside)
        contentView.addSubview(signUp)
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
            
            image.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 130),
            image.heightAnchor.constraint(equalToConstant: 130),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 55),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            signUp.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            signUp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            signUp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            signUp.heightAnchor.constraint(equalToConstant: 50),
            signUp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
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
    
    @objc private func newAccountAction(){
        print("кнопка нажата")
        let password = password.text ?? ""
        let number = number.text ?? ""
        let name = name.text ?? ""
        let specificKey = "userName \(number)"
        guard !name.isEmpty else {
            alert(title: "⚠️", message: "Введите имя", success: false)
            return
        }
        guard !number.isEmpty else {
            alert(title: "⚠️", message: "Введите номер", success: false)
            return
        }
        guard !password.isEmpty else {
            alert(title: "⚠️", message: "Введите пароль", success: false)
            return
        }
        guard let passwordData = password.data(using: .utf8) else {return}
        
        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: number
        ]
        SecItemDelete(deleteQuery as CFDictionary)
        print("delete")
        let addQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: number,
            kSecValueData as String: passwordData
        ]
        print("add")
        let status = SecItemAdd(addQuery as CFDictionary, nil)
        print("проверка статуса")
        if status == errSecSuccess {
            print("\(status)")
            UserDefaults.standard.set(name, forKey: specificKey)
            alert(title: "Ура", message: "Данные успешно сохранены. Теперь можно войти в приложение", success: true)
        } else {
            print("\(status)")
            alert(title: "Упс", message: "Ошибка сохранения. Попробуйте еще раз", success: false)
        }
    }
    
    private func alert(title: String, message: String, success: Bool){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default){_ in
            if success{
                let mainVC = LoginViewController()
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    UIView.transition(with: window, duration: 0.3,options: .transitionCrossDissolve){
                        window.rootViewController = mainVC
                    }
                }
            }
        })
        self.present(alert, animated: true)
    }
}
extension SignUpViewController: UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.black.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
}

//#Preview{
//    SignUpViewController()
//}
