//
//  HeaderView.swift
//  RecipesApp
//
//  Created by Владислав on 30.08.2023.
//

import UIKit

class HeaderView: UIView {
    enum Constants {
        static let titleLabelTopSpacing: CGFloat = 0.0
        static let titleLabelLeadingSpacing: CGFloat = 19.0
        static let recipeImageViewTopSpacing: CGFloat = 12.0
        static let recipeImageViewLeadingSpacing: CGFloat = 8.0
        static let nameRecipeTextFieldTopSpacing: CGFloat = 10.0
        static let nameRecipeTextFieldLeadingSpacing: CGFloat = 16.0
    }

    //MARK: - Create UI
    
    private lazy var titleLabel = UILabel(text: "Create recipe", font: .poppinsBold24(), textColor: .neutral100)
    
    private lazy var recipeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "sex")
        return imageView
    }()
    
    private lazy var nameRecipeTextField = CreateRecipeTextField()
    
    private lazy var backViewServes = UIView(backgroundColor: .neutral10, cornerRadius: 12)
    
    private lazy var whiteViewServes = UIView(backgroundColor: .neutral0, cornerRadius: 10)
    
    private lazy var usersImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "user2")
        return imageView
    }()
    
    private lazy var servesLabel = UILabel(text: "Serves", font: .poppinsBold16(), textColor: .neutral100)
    
    public lazy var servesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .neutral100
        return button
    }()
    
    public lazy var servesNumberLabel = UILabel(text: "01", font: .poppinsRegular14(), textColor: .neutral50)
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(recipeImageView)
        addSubview(nameRecipeTextField)
        addSubview(backViewServes)
        backViewServes.addSubview(whiteViewServes)
        whiteViewServes.addSubview(usersImageView)
        backViewServes.addSubview(servesLabel)
        backViewServes.addSubview(servesButton)
        backViewServes.addSubview(servesNumberLabel)
    }
    
    public func getNameTextFieldText() -> String {
        guard let text = nameRecipeTextField.text else { return "" }
        return text
    }
    
    public func deleteTextFieldText() {
        nameRecipeTextField.text = ""
    }
}

extension HeaderView: ServesTableViewControllerDelegate {
    func didSelectServesNumber(_ number: String) {
        servesNumberLabel.text = number
    }
}

//MARK: - setConstraints

extension HeaderView {
    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleLabelTopSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleLabelLeadingSpacing)
        ])
        
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.recipeImageViewTopSpacing),
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.recipeImageViewLeadingSpacing),
            recipeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.recipeImageViewLeadingSpacing),
            recipeImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
        nameRecipeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameRecipeTextField.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: Constants.nameRecipeTextFieldTopSpacing),
            nameRecipeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.nameRecipeTextFieldLeadingSpacing),
            nameRecipeTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.nameRecipeTextFieldLeadingSpacing),
            nameRecipeTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        backViewServes.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backViewServes.topAnchor.constraint(equalTo: nameRecipeTextField.bottomAnchor, constant: 16),
            backViewServes.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backViewServes.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            backViewServes.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        whiteViewServes.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            whiteViewServes.centerYAnchor.constraint(equalTo: backViewServes.centerYAnchor),
            whiteViewServes.leadingAnchor.constraint(equalTo: backViewServes.leadingAnchor, constant: 16),
            whiteViewServes.widthAnchor.constraint(equalToConstant: 36),
            whiteViewServes.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        usersImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usersImageView.centerYAnchor.constraint(equalTo: whiteViewServes.centerYAnchor),
            usersImageView.centerXAnchor.constraint(equalTo: whiteViewServes.centerXAnchor),
            usersImageView.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        servesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            servesLabel.centerYAnchor.constraint(equalTo: backViewServes.centerYAnchor),
            servesLabel.leadingAnchor.constraint(equalTo: whiteViewServes.trailingAnchor, constant: 16)
        ])
        
        servesNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            servesNumberLabel.centerYAnchor.constraint(equalTo: backViewServes.centerYAnchor),
            servesNumberLabel.trailingAnchor.constraint(equalTo: servesButton.leadingAnchor, constant: -8)
        ])
        
        servesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            servesButton.centerYAnchor.constraint(equalTo: backViewServes.centerYAnchor),
            servesButton.trailingAnchor.constraint(equalTo: backViewServes.trailingAnchor, constant: -16)
        ])
    }
}
