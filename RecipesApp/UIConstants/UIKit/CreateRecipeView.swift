//
//  CrreateRecipeBackView.swift
//  RecipesApp
//
//  Created by Владислав on 05.09.2023.
//

import UIKit

extension UIView {
    convenience init(backgroundColor: UIColor, cornerRadius: CGFloat) {
        self.init()
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
    }
}
