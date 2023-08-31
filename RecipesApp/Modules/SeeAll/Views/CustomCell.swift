//  CustomCell.swift
//  RecipesApp
//
//  Created by Elshad Babaev on 30.08.2023.
//

import UIKit

class CustomCell: UITableViewCell {
    // MARK: - Visual Components
    
    static let identifier = "CustomCell"
    
    private let ratingView: RatingView = {
        let ratingView = RatingView()
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.layer.cornerRadius = 8
        ratingView.clipsToBounds = true
        
        return ratingView
    }()
    
    
    private let mealNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "How to make yam & vegetable sauce at home"
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mealImage")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "9 Ingredients | 25 min"
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Init
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    @available(*, unavailable)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        contentView.addSubview(mealImageView)
        contentView.addSubview(mealNameLabel)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(ratingView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mealImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            mealImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            mealImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mealImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            ratingView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            ratingView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            ratingView.heightAnchor.constraint(equalToConstant: 28),
            ratingView.widthAnchor.constraint(equalToConstant: 55),
            
            mealNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 110),
            mealNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 35),
            mealNameLabel.heightAnchor.constraint(equalToConstant: 55),
            mealNameLabel.widthAnchor.constraint(equalToConstant: 300),
            
            ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            ingredientsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 170)
            
            
            
            
        ])
    }
}

// MARK: - Public Methods

//    func configure(with viewModel: ViewModel) {
//        label.text = viewModel.text
//        label.font = viewModel.font
//        label.textColor = viewModel.textColor
//        emojiView.isHidden = (viewModel.emoji == nil)
//        emojiView.image = viewModel.emoji?.image(withSize: 40)
//    }

// MARK: - View Model

//extension CustomCell {
//    struct ViewModel {
//        let text: String
//        let font: UIFont
//        let textColor: UIColor
//        let emoji: String?
//
//        init(text: String,
//             font: UIFont = .systemFont(ofSize: 34, weight: .bold),
//             textColor: UIColor = .black,
//             emoji: String? = nil) {
//            self.text =  text
//            self.font = font
//            self.textColor = textColor
//            self.emoji = emoji
//        }
//}

