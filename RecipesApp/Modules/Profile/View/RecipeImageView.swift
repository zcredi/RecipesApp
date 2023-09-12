import UIKit

final class RecipeImageView: UIImageView {
    let recipeNameLabel = UILabel(text: "How to make yam & vegetable sauce at home",
                                  font: .poppinsBold20(),
                                  textColor: .white,
                                  numberOfLines: 1)
  
    let ingredientsLabel = UILabel(text: "9 ingredients", font: .poppinsRegular12(), textColor: .white, numberOfLines: 1)
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .white
        return lineView
    }()

    let cookingTime = UILabel(text: "25 min", font: UIFont.poppinsRegular12(), textColor: .white, numberOfLines: 1)
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage(named: "Thomas Keller")
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        setupView()
        layoutUI()
        lineView.translatesAutoresizingMaskIntoConstraints = false
    }
  
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    // MARK: - Private Methods

    private func setupView() {
        addSubviews(recipeNameLabel, ingredientsLabel, lineView, cookingTime)
        recipeNameLabel.numberOfLines = 0
    }
  
    // MARK: - Layout

    private func layoutUI() {
        

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
