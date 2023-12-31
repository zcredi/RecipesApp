import UIKit
import SnapKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var authManager = FireBaseAuthManager()
    private lazy var titleLabel = UILabel(text: "Login", font: UIFont.systemFont(ofSize: 20, weight: .bold), textColor: .black, numberOfLines: 1)
    private lazy var emailLabel = UILabel(text: "eMail", font: UIFont.systemFont(ofSize: 20, weight: .bold), textColor: .black, numberOfLines: 1)
    private lazy var pwdLabel = UILabel(text: "Password", font: UIFont.systemFont(ofSize: 20, weight: .bold), textColor: .red, numberOfLines: 1)
       
    private lazy var signUpLabel: UILabel = {
        let label = UILabel(text: "Not account here - please, ", font: UIFont.systemFont(ofSize: 20, weight: .bold), textColor: .black, numberOfLines: 1)
        label.textAlignment = .center
        return label
    } ()
    private lazy var emailtextField = UITextField(placeholder: "eMail", font: .systemFont(ofSize: 15))
      
    private lazy var pwdtextField: UITextField = {
        let field = UITextField(placeholder: "password", font: .systemFont(ofSize: 15))
        field.isSecureTextEntry = true
        return field
    } ()
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("SignIn", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.gray
        return button
    } ()
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("signup", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.blue, for: .normal)
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        makeLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _ = Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                let vc = MainTabBarController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            } else {
                
            }
        }
        
    }
    
    func setupViews() {
        view.addSubviews(titleLabel, emailLabel, emailtextField, pwdLabel, pwdtextField, loginButton, signUpLabel, registerButton)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    func makeLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(30)
        }
        
        emailtextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
        }
        
        pwdLabel.snp.makeConstraints { make in
            make.top.equalTo(emailtextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(30)
        }
        
        pwdtextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.top.equalTo(pwdLabel.snp.bottom).offset(20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(pwdtextField.snp.bottom).offset(15)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.height.equalTo(25)
            make.top.equalTo(loginButton.snp.bottom).offset(40)
        }
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.leading.equalTo(signUpLabel.snp.trailing).offset(4)
            make.top.equalTo(loginButton.snp.bottom).offset(40)
        }
        
    }
}

extension LoginViewController {
    @objc func loginButtonTapped() {
        
        authManager.signIn(eMail: emailtextField.text ?? "" , pwd: pwdtextField.text ?? "") { result in
            switch result {
            case .success( _):
                let vc = MainTabBarController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
        
    }
    
    @objc func registerButtonTapped() {
        
        
    }
}
