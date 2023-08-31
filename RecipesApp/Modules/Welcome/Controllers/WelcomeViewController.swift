import UIKit

class WelcomeViewController: UIViewController {
    
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        return imageView
    }()
    

    lazy var titleText: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Best Recipe"
        title.textAlignment = .center
        title.font = .poppinsBold56()
        title.textColor = .white
        
        return title
    }()
    
    lazy var subtitleText: UILabel = {
        let title = UILabel()
        title.numberOfLines = 1
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Find best recipes for cooking"
        title.textAlignment = .center
        title.font = .poppinsRegular16()
        title.textColor = .white
        
        return title
    }()

    
    lazy var titleStack: UIStackView = {

        let textStackView = UIStackView(arrangedSubviews: [titleText, subtitleText])
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.alignment = .center
        textStackView.axis = .vertical
        textStackView.spacing = 15
        textStackView.distribution = .fill
        
        return textStackView
    }()
    
    
    lazy var buttonView: UIButton = {
        var button = UIButton()
        button.setTitle("Get started", for: .normal)
        button.titleLabel?.font = .poppinsBold16()
        button.backgroundColor = .primary50
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        button.widthAnchor.constraint(equalToConstant: 156).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(startedButton), for: .touchUpInside)
        
        return button
        
    }()
    
    static let label: UILabel = {
        let label = UILabel()
        label.font = .poppinsRegular16()
        label.textColor = .white
        label.text = "100k+ Premium recipes"
        
        return label
    }()
    
    
    static let labelIcon: UIImageView = {
        var image = UIImage(systemName: "star.fill")
        let icon = UIImageView(image: image)
        icon.tintColor = .black
        return icon
        }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelIcon,label])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    
    @objc func startedButton() {
        let vc = OnboardingViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        show(vc, sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()  
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.sizeToFit()
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        view.addSubview(buttonView)

        NSLayoutConstraint.activate([
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
          
        ])
        
        view.addSubview(titleStack)

        NSLayoutConstraint.activate([
            titleStack.bottomAnchor.constraint(equalTo: buttonView.topAnchor, constant: -32),
            titleStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])

        view.addSubview(labelStackView)
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            labelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
}

