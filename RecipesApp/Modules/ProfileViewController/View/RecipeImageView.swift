//
//  RecipeImageView.swift
//  RecipesApp
//
//  Created by Андрей Фроленков on 4.09.23.
//

import Foundation
import UIKit

final class RecipeImageView: UIImageView {
  
  let recipeNameLabel = UILabel(text: "How to make yam & vegetable sauce at home",
                                font: UIFont.poppinsBold20(),
                                textColor: UIColor.white)
  
  let ingredientsLabel = UILabel(text: "9 ingredients", font: UIFont.poppinsRegular12(), textColor: UIColor.white)
  lazy var lineView: UIView = {
    let lineView = UIView()
    lineView.backgroundColor = .white
    return lineView
  }()
  let cookingTime = UILabel(text: "25 min", font: UIFont.poppinsRegular12(), textColor: UIColor.white)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    layoutUI()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Methods
  private func setupView() {
    addSubviews(recipeNameLabel)
    addSubviews(ingredientsLabel)
    addSubviews(lineView)
    addSubviews(cookingTime)
    
    
    recipeNameLabel.numberOfLines = 0
  }
  
  // MARK: - Layout
  private func layoutUI() {
    recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
    ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
    lineView.translatesAutoresizingMaskIntoConstraints = false
    cookingTime.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      recipeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      recipeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      
      ingredientsLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 8),
      ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      ingredientsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
      
      lineView.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 8),
      lineView.leadingAnchor.constraint(equalTo: ingredientsLabel.trailingAnchor, constant: 8),
      lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
      
      lineView.widthAnchor.constraint(equalToConstant: 2),
      
      cookingTime.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 8),
      cookingTime.leadingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 8),
      cookingTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
    ])
  }
}

