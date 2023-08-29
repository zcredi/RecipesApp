//
//  CastomTableViewCell.swift
//  RecipesApp
//
//  Created by Maria on 29.08.2023.
//

import Foundation
import UIKit
import SnapKit

class CustomViewTableCell: UITableViewCell {
    
    private let spinner = UIActivityIndicatorView(style: .large)
    
    private let recipeImage: UIImageView = {
        
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
        image.clipsToBounds=true
        return image
        
    } ()
    
    private let authorImage: UIImageView = {
        
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
        image.clipsToBounds=true
        return image
        
    } ()
    
    private let recipeNameLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.poppinsBold16()
        label.textColor = .label
        return label
        
    } ()
    
    private let authorNameLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.poppinsRegular12()
        label.textColor = .neutral50
        return label
        
    } ()
    
    private let ratingLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.poppinsBold14()
        label.textColor = .white
        return label
        
    } ()
    
    private let cookingTimeLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.poppinsRegular12()
        label.textColor = .white
        return label
        
    } ()
}
