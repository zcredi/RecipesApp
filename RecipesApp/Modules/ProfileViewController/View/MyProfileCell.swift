//
//  MyProfileCell.swift
//  RecipesApp
//
//  Created by Андрей Фроленков on 4.09.23.
//

import Foundation
import UIKit

// MARK: - MyProfileCell
final class MyProfileCell: UITableViewCell {
  
  static let identifier = "MyProfileCell"
  
  lazy var photoImageView: UIImageView = {
    let photoImageView = UIImageView()
    photoImageView.image = UIImage(named: "Christina Tosi")
    photoImageView.layer.cornerRadius = 50
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
      photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
      photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
      photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
      
      photoImageView.heightAnchor.constraint(equalToConstant: 100),
      photoImageView.widthAnchor.constraint(equalToConstant: 100),
    ])
  }
}
