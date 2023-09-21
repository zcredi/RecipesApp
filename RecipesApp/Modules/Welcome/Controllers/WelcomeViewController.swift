import UIKit
import FirebaseAuth
class WelcomeViewController: UIViewController {
    let backgroundImageView = UIImageView(image: "background", cornerRadius: 0)
    lazy var titleText = UILabel(text: "Best Recipe", font: .poppinsBold56(), textColor: .white, numberOfLines: 0)
    lazy var subtitleText = UILabel(text: "Find best recipes for cooking", font: .poppinsRegular16(), textColor: .white, numberOfLines: 1)
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
        var button = UIButton(name: "Get started", backgroundColor: .primary50, font: .poppinsBold16(), titleColor: .white)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(startedButton), for: .touchUpInside)
        
        return button
        
    }()
    
    static let label =  UILabel(text: "100k+ Premium recipes", font: .poppinsRegular16(), textColor: .white, numberOfLines: 0)
    
    
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
        
        present(vc, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(backgroundImageView, buttonView, titleStack, labelStackView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.sizeToFit()
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.heightAnchor.constraint(equalToConstant: 56),
            buttonView.widthAnchor.constraint(equalToConstant: 156)

          
        ])

        NSLayoutConstraint.activate([
            titleStack.bottomAnchor.constraint(equalTo: buttonView.topAnchor, constant: -32),
            titleStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    
        ])
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            labelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
}

