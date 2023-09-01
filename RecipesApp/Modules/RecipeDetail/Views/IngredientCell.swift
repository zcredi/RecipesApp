//
//  IngredientCell.swift
//  RecipesApp
//
//  Created by Андрей Фроленков on 30.08.23.
//

import Foundation
import UIKit

// MARK: - IngredientCell
final class IngredientCell: UITableViewCell {
  
  static let identifier = "IngredientCell"
  var choiceIngredientImage = false
  
  lazy var ingredientImage: UIImageView = {
    let ingredientImage = UIImageView()
    ingredientImage.contentMode = .scaleAspectFill
    ingredientImage.layer.cornerRadius = 10
    ingredientImage.clipsToBounds = true
    ingredientImage.image = UIImage(named: "recipeImage")
    return ingredientImage
  }()
  
  lazy var ingredientName = UILabel(text: "Fish", font: UIFont.poppinsBold16(), textColor: UIColor.neutral100)
  lazy var ingredientWeight = UILabel(text: "250g", font: UIFont.poppinsRegular14(), textColor: UIColor.neutral50)
  
  lazy var ingredientSelectButton: UIButton = {
    let ingredientSelectButton = UIButton()
    ingredientSelectButton.setImage(UIImage(named: "notSelected"), for: .normal)
    return ingredientSelectButton
  }()
  
  // MARK: - Initializers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.layer.cornerRadius = 10
    contentView.backgroundColor = UIColor.neutral10
    setupCell()
    layoutUI()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
  }
  
  // MARK: - Actions
  @objc
  private func choiceIngredientTap(_ sender: UIButton) {
    choiceIngredientImage = !choiceIngredientImage
    checkmark()
  }
  
  
  // MARK: - Private Methods
  private func setupCell() {
    
    selectionStyle = .none
    
    contentView.addSubview(ingredientImage)
    contentView.addSubview(ingredientName)
    contentView.addSubview(ingredientWeight)
    contentView.addSubview(ingredientSelectButton)
    
    ingredientSelectButton.addTarget(self, action: #selector(choiceIngredientTap), for: .touchUpInside)
    
  }
  
  func checkmark() {
    let image = choiceIngredientImage ? UIImage(named: "selected") : UIImage(named: "notSelected")
    ingredientSelectButton.setImage(image, for: .normal)
  }
  
  private func layoutUI() {
    ingredientImage.translatesAutoresizingMaskIntoConstraints = false
    ingredientName.translatesAutoresizingMaskIntoConstraints = false
    ingredientWeight.translatesAutoresizingMaskIntoConstraints = false
    ingredientSelectButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      ingredientImage.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
      ingredientImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      ingredientImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      ingredientImage.heightAnchor.constraint(equalToConstant: 40),
      ingredientImage.widthAnchor.constraint(equalToConstant: 40),
      
      ingredientName.leadingAnchor.constraint(equalTo: ingredientImage.trailingAnchor, constant: 20),
      ingredientName.centerYAnchor.constraint(equalTo: ingredientImage.centerYAnchor),
      
      ingredientWeight.leadingAnchor.constraint(equalTo: ingredientName.trailingAnchor, constant: 20),
      ingredientWeight.centerYAnchor.constraint(equalTo: ingredientImage.centerYAnchor),
      
      ingredientSelectButton.leadingAnchor.constraint(equalTo: ingredientWeight.trailingAnchor, constant: 20),
      ingredientSelectButton.centerYAnchor.constraint(equalTo: ingredientImage.centerYAnchor),
      ingredientSelectButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
      
    ])
  }
}

