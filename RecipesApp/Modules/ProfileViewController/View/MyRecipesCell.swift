//
//  MyRecipesCell.swift
//  RecipesApp
//
//  Created by Андрей Фроленков on 4.09.23.
//

import Foundation
import UIKit

// MARK: - MyRecipesCell
final class MyRecipesCell: UITableViewCell {
  
  static let identifier = "MyRecipesCell"
  
  lazy var photoImageView: RecipeImageView = {
    let photoImageView = RecipeImageView(frame: .zero)
    photoImageView.image = UIImage(named: "Thomas Keller")
    photoImageView.contentMode = .scaleAspectFill
    photoImageView.layer.cornerRadius = 10
    photoImageView.clipsToBounds = true
    return photoImageView
  }()
  
  // MARK: - Initializers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupCell()
    layoutUI()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
 
  // MARK: - Private Methods
  private func setupCell() {
    selectionStyle = .none
    contentView.addSubviews(photoImageView)
    
  }
  
  // MARK: - Layout
  private func layoutUI() {
    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
      photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      
      photoImageView.heightAnchor.constraint(equalToConstant: 200),
     
    ])
  }
}
