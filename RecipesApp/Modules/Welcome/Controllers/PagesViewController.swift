//
//  PagesViewController.swift
//  RecipesApp
//
//  Created by Anna Zaitsava on 30.08.23.
//

import UIKit

class PagesViewController: UIViewController {
    
    var imageName: String
    var titleTextFirstPart: String
    var titleTextSecondPart: String
    var subtitleText: String
    
    
    init(imageName: String, titleTextFirstPart: String, titleTextSecondPart: String, subtitleText: String) {
        self.imageName = imageName
        self.titleTextFirstPart = titleTextFirstPart
        self.titleTextSecondPart = titleTextSecondPart
        self.subtitleText = subtitleText
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var onboardingImage: UIImageView = {
        let imageName = imageName
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        return imageView
    }()
    
    lazy var onboardingTitle: UILabel = {
        let title = UILabel(text: "", font: .poppinsBold40(), textColor: .white, numberOfLines: 0)
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: titleTextFirstPart, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]));
        text.append(NSAttributedString(string: titleTextSecondPart, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondary20]))
        
        title.attributedText = text
        return title
    }()
    
    lazy var onboardingSubtitle = UILabel(text: subtitleText, font: .poppinsRegular16(), textColor: .white, numberOfLines: 0)
       
    
    lazy var textStack: UIStackView = {
        let textStackView = UIStackView(arrangedSubviews: [onboardingTitle, onboardingSubtitle])
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.alignment = .center
        textStackView.axis = .vertical
        textStackView.spacing = 15
        textStackView.distribution = .fill
        
        return textStackView
    }()
    
    
    override func loadView() {
        super.loadView()
        
        view.addSubviews(onboardingImage, textStack)
        onboardingImage.translatesAutoresizingMaskIntoConstraints = false
        onboardingImage.sizeToFit()
        
        NSLayoutConstraint.activate([
            onboardingImage.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            
            textStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -162),
            textStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            textStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}


