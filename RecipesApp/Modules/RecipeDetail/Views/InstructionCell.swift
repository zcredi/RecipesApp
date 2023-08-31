//
//  InstructionCell.swift
//  RecipesApp
//
//  Created by Андрей Фроленков on 30.08.23.
//

import Foundation
import UIKit

// MARK: - InstructionCell
final class InstructionCell: UITableViewCell {
  
  static let identifier = "InstructionCell"
  
  lazy var stepLabel = UILabel(text: "Place eggs in a saucepan and cover with cold water. Bring water to a boil and immediately remove from heat. Cover and let eggs stand in hot water for 10 to 12 minutes. Remove from hot water, cool, peel, and chop.", font: .poppinsRegular16(), textColor: .black)

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
  
  override func layoutSubviews() {
    super.layoutSubviews()

  }
  
  // MARK: - Private Methods
  private func setupCell() {
    contentView.addSubview(stepLabel)
    
    isUserInteractionEnabled = false
    
    stepLabel.adjustsFontSizeToFitWidth = false
    stepLabel.numberOfLines = 0
  }
  
  private func layoutUI() {
    stepLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      
      stepLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      stepLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
      stepLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
      stepLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
      
    ])
  }
}
