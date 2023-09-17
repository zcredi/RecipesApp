import Firebase
import GoogleSignIn
import GoogleSignInSwift
import UIKit

class AuthorizationViewController: UIViewController {
    private let titleLabel = UILabel(text: "My Recipe App", font: .systemFont(ofSize: 24, weight: .bold), textColor: .black, numberOfLines: 0)
    
    private let GIDButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Аккаунт (введите логин)"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль (введите пароль)"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton(name: "Create Account", backgroundColor: .blue, font: nil, titleColor: .systemBackground)
        button.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
       
    
    private let loginButton: UIButton = {
        let button = UIButton(name: "Sign in", backgroundColor: .green, font: nil, titleColor: .systemBackground)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        checkAutorization()
    }
    
    func checkAutorization() {
        if Auth.auth().currentUser != nil {
            showMainTabBar()
        } else {
            view.backgroundColor = .systemBackground
            setupViews()
            layoutViews()
        }
    }
    
    func showMainTabBar() {
        let vc = MainTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
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
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                print("Error: \(error?.localizedDescription ?? "No error description")")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("Error: No user or idToken")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { [unowned self] result, error in
                guard error == nil else {
                    print("Error: \(error?.localizedDescription)")
                    return
                }

                guard let user = result?.user else {
                    print("Error: No user")
                    return
                }

                let vc = MainTabBarController()
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
            }
        }
    }
    
    @objc func createAccountTapped() {
        // Реализуй этот метод, чтобы открыть экран регистрации или выполнить другое действие
    }
    
    @objc func loginTapped() {
        // Получаем введенные email и пароль
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            print("Error: Email or Password is empty")
            return
        }

        // Вход в аккаунт с использованием Firebase
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard error == nil else {
                print("Login error: \(error!.localizedDescription)")
                return
            }
        }
    }
}
