import AlertKit
import UIKit

class RegistrationViewController: UIViewController {
    private var registrationViewModel = RegistrationViewModel()
    private lazy var registrationLabel = UILabel(text: "Registration Account", font: .boldSystemFont(ofSize: 40), textColor: UIColor(named: "blackWhite")!, numberOfLines: 1)
      
    private lazy var accountTextField: UITextField = {
        let textField = UITextField(placeholder: "Account (Enter your email)", delegate: self)
        textField.keyboardType = .emailAddress
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField(placeholder: "Password (Enter your password", delegate: self)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton(name: "Create Account", backgroundColor: .systemBlue, font: .systemFont(ofSize: 15), titleColor: .white)
        button.addTarget(self, action: #selector(createAccountButtonPressed(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        print("Create Account button pressed")
        guard let email = accountTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            textFieldEmptyError()
            return
        }
        registrationViewModel.createUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.successCreateAccount()
            case .failure(let failure):
                self?.authorizationError(error: failure)
            }
        }
    }
    
    private func textFieldEmptyError() {
        AlertKitAPI.present(title: "Error", subtitle: "Not all fields are filled in for registration", icon: .error, style: .iOS16AppleMusic, haptic: .error)
    }
    
    private func authorizationError(error: Error) {
        if let firebaseError = FirebaseAuthError(from: error) {
            AlertKitAPI.present(title: "Error", subtitle: firebaseError.rawValue, icon: .error, style: .iOS16AppleMusic, haptic: .error)
        }
    }
    
    
    private func successCreateAccount() {
        AlertKitAPI.present(title: "The account was created", subtitle: nil, icon: .done, style: .iOS16AppleMusic, haptic: .success)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.dismiss(animated: true)
            self.logIn()
        }
    }
    
    private func logIn() {
        guard let window = UIApplication.shared.delegate?.window else { return }
        
        let mainTabBarController = MainTabBarController()

        // Анимационный переход между старым и новым rootViewController
        UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window?.rootViewController = mainTabBarController
        }, completion: nil)
    }
    
    private func setupUI() {
        view.addSubviews(registrationLabel, accountTextField, passwordTextField, createAccountButton)
        NSLayoutConstraint.activate([
            registrationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            registrationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registrationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            accountTextField.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 150),

            accountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            accountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            accountTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: accountTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            createAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
