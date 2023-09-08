//
//  IngredientsCollectionViewCell.swift
//  RecipesApp
//
//  Created by Владислав on 07.09.2023.
//

import UIKit

class IngredientsCollectionViewCell: UICollectionViewCell {
    enum Constants {
        static let labelHeight: CGFloat = 35.0
        static let labelLeadingSpacing: CGFloat = 26.0
        static let quantityLabelLeadingSpacing: CGFloat = 12.0
        static let itemLabelWidth: CGFloat = 164.0
        static let quantityLabelWidth: CGFloat = 115.0
    }
    
    //MARK: - Create UI
    
//    private lazy var itemLabel = UILabel(font: .poppinsRegular14(), textColor: .neutral100)
//    
//    private lazy var quantityLabel = UILabel(font: .poppinsRegular14(), textColor: .neutral100)
    
    private lazy var itemLabel = CreateRecipeTextField()
    
    private lazy var quantityLabel = CreateRecipeTextField()
    
    public lazy var deleteItemButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "minus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
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
        addSubview(itemLabel)
        itemLabel.layer.borderColor = UIColor.neutral20.cgColor
        addSubview(quantityLabel)
        quantityLabel.layer.borderColor = UIColor.neutral20.cgColor
        addSubview(deleteItemButton)
    }
    
    func configureCell(model: IngredientsItemModel) {
        itemLabel.text = "   " + model.itemName
        quantityLabel.text = "   " + model.quantity
    }
    
    //MARK: - setConstraints
    
    private func setConstraints() {
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.labelLeadingSpacing),
            itemLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            itemLabel.widthAnchor.constraint(equalToConstant: Constants.itemLabelWidth)
        ])
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityLabel.leadingAnchor.constraint(equalTo: itemLabel.trailingAnchor, constant: Constants.quantityLabelLeadingSpacing),
            quantityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            quantityLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            quantityLabel.widthAnchor.constraint(equalToConstant: Constants.quantityLabelWidth)
        ])
        
        deleteItemButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteItemButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: Constants.quantityLabelLeadingSpacing),
            deleteItemButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteItemButton.heightAnchor.constraint(equalToConstant: 24),
            deleteItemButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}
