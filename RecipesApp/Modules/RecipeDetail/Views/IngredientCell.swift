import Foundation
import Kingfisher
import UIKit

final class IngredientCell: UITableViewCell {
    static let identifier = "IngredientCell"
    
    var choiceIngredientImage = false
  
    lazy var ingredientImage = UIImageView(image: "recipeImage", cornerRadius: 10)
    
    private lazy var ingredientName = UILabel(text: "Fish", font: UIFont.poppinsBold12(), textColor: UIColor(named: "blackWhite")!, numberOfLines: 0)
    lazy var ingredientWeight = UILabel(text: "250g", font: UIFont.poppinsRegular14(), textColor: UIColor(named: "blackWhite")!, numberOfLines: 1)
  
    lazy var ingredientSelectButton: UIButton = {
        let ingredientSelectButton = UIButton()
        ingredientSelectButton.setImage(UIImage(named: "notSelected"), for: .normal)
        return ingredientSelectButton
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .clear
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
    
    private func setupCell() {
        selectionStyle = .none
    
        contentView.addSubview(ingredientImage)
        contentView.addSubview(ingredientName)
        contentView.addSubview(ingredientWeight)
        contentView.addSubview(ingredientSelectButton)
    }
  
    func checkmark(isSelected: Bool) {
        let image = isSelected ? UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal) : UIImage(systemName: "circle")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        ingredientSelectButton.setImage(image, for: .normal)
    }
    
    func uncheck() {
        ingredientSelectButton.setImage(UIImage(named: "notSelected"), for: .normal)
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
            ingredientName.trailingAnchor.constraint(equalTo: ingredientWeight.leadingAnchor, constant: -20),
            
            ingredientName.centerYAnchor.constraint(equalTo: ingredientImage.centerYAnchor),
      
            ingredientWeight.leadingAnchor.constraint(equalTo: ingredientName.trailingAnchor, constant: 20),
            ingredientWeight.centerYAnchor.constraint(equalTo: ingredientImage.centerYAnchor),
      
            ingredientSelectButton.leadingAnchor.constraint(equalTo: ingredientWeight.trailingAnchor, constant: 20),
            ingredientSelectButton.centerYAnchor.constraint(equalTo: ingredientImage.centerYAnchor),
            ingredientSelectButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
      
        ])
    }
    
    public func configure(ingredient: Ingredient) {
        if !ingredient.image.isEmpty {
            guard let url = URL(string: "https://spoonacular.com/cdn/ingredients_250x250/" + ingredient.image) else { return }
            self.ingredientImage.kf.setImage(with: url)
        }
        self.ingredientName.text = ingredient.name
    }
}
