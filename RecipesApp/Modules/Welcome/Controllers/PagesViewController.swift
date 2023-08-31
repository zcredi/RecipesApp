//
//  PagesViewController.swift
//  RecipesApp
//
//  Created by Anna Zaitsava on 30.08.23.
//

import UIKit

class PagesViewController: UIViewController {
    
    var imageName: String
    var titleText: String
    var subtitleText: String?
    
    
    init(imageName: String, titleText: String, subtitleText: String) {
        self.imageName = imageName
        self.titleText = titleText
        self.subtitleText? = subtitleText
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
        let title = UILabel()
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = titleText
        title.textAlignment = .center
        title.font = .poppinsBold40()
        title.textColor = .secondary20
        
        return title
    }()
    
    lazy var onboardingSubtitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = subtitleText
        title.textAlignment = .center
        title.font = .poppinsRegular16()
        title.textColor = .white
        title.numberOfLines = 0
        
        return title
    }()
    
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
        
        view.addSubview(onboardingImage)
        onboardingImage.translatesAutoresizingMaskIntoConstraints = false
        onboardingImage.sizeToFit()
        
        NSLayoutConstraint.activate([
            onboardingImage.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(textStack)
        
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


