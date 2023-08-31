//  CustomCell.swift
//  RecipesApp
//
//  Created by Elshad Babaev on 30.08.2023.
//

import UIKit

class CustomCell: UITableViewCell {
    // MARK: - Visual Components
        
        static let identifier = "CustomCell"
    
    
    private let mealNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let ingridientsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Init
    
    @available(*, unavailable)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
            setupConstraints()
        }
        
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    //    func configure(with viewModel: ViewModel) {
    //        label.text = viewModel.text
    //        label.font = viewModel.font
    //        label.textColor = viewModel.textColor
    //        emojiView.isHidden = (viewModel.emoji == nil)
    //        emojiView.image = viewModel.emoji?.image(withSize: 40)
    //    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        contentView.addSubview(mealImageView)
        contentView.addSubview(mealNameLabel)
        contentView.addSubview(ingridientsLabel)
        contentView.addSubview(timeLabel)
        
        
        
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
    }
}

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

