import UIKit
import GoogleSignIn
import AlertKit

class AuthorizationViewController: UIViewController {
    
    private var authorizationViewModel = AutrhorizationViewModel()
    
    private lazy var titleLabel = UILabel(text: "My Recipe App", font: .systemFont(ofSize: 24, weight: .bold), textColor: UIColor(named: "blackWhite")!, numberOfLines: 0)
    
    private lazy var GIDButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField(placeholder: "Аккаунт (введите логин)", delegate: self)
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField(placeholder: "Пароль (введите пароль)", delegate: self)
        textField.placeholder = "Пароль (введите пароль)"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var  createAccountButton: UIButton = {
        let button = UIButton(name: "Create Account", backgroundColor: .systemBlue, font: nil, titleColor: .white)
        button.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
       
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(name: "Sign in", backgroundColor: .systemGreen, font: nil, titleColor: .white)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        checkAutorization()
    }
    
    func checkAutorization() {
        authorizationViewModel.checkAuthorization { [weak self] isAuthorized in
            if isAuthorized {
                self?.showMainTabBar()
            } else {
                self?.view.backgroundColor = .systemBackground
                self?.setupViews()
                self?.layoutViews()
            }
        }
    }
    
    func showMainTabBar() {
        guard let window = UIApplication.shared.delegate?.window else { return }
        
        let mainTabBarController = MainTabBarController()

        // Анимационный переход между старым и новым rootViewController
        UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window?.rootViewController = mainTabBarController
        }, completion: nil)
    }
    
    func showAlertError(error: Error) {
        AlertKitAPI.present(title: "Error", subtitle: "\(error)", icon: .error, style: .iOS16AppleMusic, haptic: .error)
    }


    
    func setupViews() {
        view.addSubviews(titleLabel, emailTextField, passwordTextField, GIDButton, createAccountButton, loginButton)
    }

    func layoutViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        GIDButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -40),
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            GIDButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            GIDButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            GIDButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            GIDButton.heightAnchor.constraint(equalToConstant: 50),
            
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.topAnchor.constraint(equalTo: GIDButton.bottomAnchor, constant: 20),
            createAccountButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 10),
            loginButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func signInWithGoogle() {
        authorizationViewModel.signInWithGoogle(vc: self) {
            self.showMainTabBar()
        }
    }
    
    @objc func createAccountTapped() {
        let vc = RegistrationViewController()
        present(vc, animated: true)
    }
    
    @objc func loginTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            print("Error: Email or Password is empty")
            return
        }
        authorizationViewModel.signInWithFirebase(email: email, password: password) { [weak self] result in
                switch result {
                case .success:
                    self?.showMainTabBar()
                case .failure(let error):
                    self?.showAlertError(error: error)
                }
            }
    }
}

extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

