//
//  RatingView.swift
//  RecipesApp
//
//  Created by Elshad Babaev on 30.08.2023.
//

import UIKit
class RatingView: UIView {
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 0.3)
        addSubview(starImageView)
        addSubview(ratingLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
        
        
        
        
        ])
    }
}
