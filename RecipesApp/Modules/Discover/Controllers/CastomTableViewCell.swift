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
        image.image = UIImage(systemName: "folder.badge.plus")
        return image
        
    } ()
    
    private let authorImage: UIImageView = {
        
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
        image.clipsToBounds=true
        image.image = UIImage(systemName: "folder.circle.fill")
        return image
        
    } ()
    private let starImage: UIImageView = {
        
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
        image.clipsToBounds=true
        image.image = UIImage(systemName: "star.fill")
        return image
        
    } ()
    
    private let recipeNameLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.poppinsBold16()
        label.textColor = .label
        label.text = "Pirogi s glazami"
        return label
        
    } ()
    
    private let authorNameLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.poppinsRegular12()
        label.textColor = .neutral50
        label.text = "Name"
        return label
        
    } ()
    
    private let ratingLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.poppinsBold14()
        label.text = "5,0"
        label.textColor = .white
        return label
        
    } ()
    
    private let cookingTimeLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.poppinsRegular12()
        label.textColor = .white
        label.text = "15:10"
        return label
        
    } ()
    
    private let ratingView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
        
    } ()
    
    private let timeView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
        
    } ()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: "reuseIdentifier")
        
        setViews()
        setupConstraines()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func setViews() {
        
        contentView.addSubview(recipeImage)
        contentView.addSubview(authorImage)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(recipeNameLabel)
        recipeImage.addSubview(ratingView)
        recipeImage.addSubview(timeView)
        ratingView.addSubview(starImage)
        ratingView.addSubview(ratingLabel)
        timeView.addSubview(cookingTimeLabel)
    }
    
    func setupConstraines() {
        
        recipeImage.snp.makeConstraints { make in
            make.height.equalTo(171)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(12)
        }
        
        ratingView.snp.makeConstraints { make in
            make.height.equalTo(27)
            make.width.equalTo(58)
            make.top.equalTo(recipeImage.snp.top).offset(8)
            make.leading.equalTo(recipeImage.snp.leading).offset(8)
        }
        timeView.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(41)
            make.bottom.equalTo(recipeImage.snp.bottom).offset(-8)
            make.trailing.equalTo(recipeImage.snp.trailing).offset(-8)
        }
        starImage.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.leading.equalTo(ratingView.snp.leading).offset(8)
            make.top.equalTo(ratingView.snp.top).offset(6)
        }
        ratingLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(24)
            make.leading.equalTo(starImage.snp.trailing).offset(4)
            make.centerY.equalTo(starImage.snp.centerY)
        }
        cookingTimeLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.width.equalTo(27)
            make.centerY.equalTo(timeView.snp.centerY)
            make.centerX.equalTo(timeView.snp.centerX)
        }
        recipeNameLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(recipeImage.snp.bottom).offset(12)
        }
        authorImage.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(32)
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(recipeNameLabel.snp.bottom).offset(5)
        }
        authorNameLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.leading.equalTo(authorImage.snp.trailing).offset(7)
            make.centerY.equalTo(authorImage.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}


