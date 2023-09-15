import UIKit
import Kingfisher

class PopularCategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "PopularCategoryCell"
    
    private lazy var categoryView = UIView(withBackgroundColor: UIColor(named: "categoryColor")!, cornerRadius: 10)
    
    private lazy var recipeImage = UIImageView(image: "sex", cornerRadius: 50)
    private lazy var recipeLabel = UILabel(text: "Chicken and Vegetable wrap", font: .poppinsBold14(), textColor: UIColor(named: "blackWhite")!, numberOfLines: 0)
    private lazy var currentTime = UILabel(text: "5 Mins", font: .poppinsBold12(), textColor: UIColor(named: "blackWhite")!, numberOfLines: 1)
    private lazy var timeLabel = UILabel(text: "Time", font: .poppinsRegular12(), textColor: .systemGray, textAligment: .left, numberOfLines: 1)
        
    
    public func configureCell(with recipe: PopularCategoryInfo) {
        guard let recipeImageUrl = URL(string: recipe.image) else { return }
        recipeImage.kf.setImage(with: recipeImageUrl)
        recipeLabel.text = recipe.title
        currentTime.text = "\(recipe.readyInMinutes) Mins"
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryView)
        addSubviews(currentTime, timeLabel, recipeLabel, recipeImage)
        
        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: topAnchor),
            categoryView.bottomAnchor.constraint(equalTo: bottomAnchor),
            categoryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            currentTime.leadingAnchor.constraint(equalTo: categoryView.leadingAnchor, constant: 10),
            currentTime.bottomAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: -10),
            
            timeLabel.leadingAnchor.constraint(equalTo: categoryView.leadingAnchor, constant: 10),
            timeLabel.bottomAnchor.constraint(equalTo: currentTime.topAnchor, constant: -5),
            
            recipeLabel.centerYAnchor.constraint(equalTo: categoryView.centerYAnchor),
            recipeLabel.leadingAnchor.constraint(equalTo: categoryView.leadingAnchor, constant: 10),
            recipeLabel.trailingAnchor.constraint(equalTo: categoryView.trailingAnchor, constant: -10),
            
            recipeImage.topAnchor.constraint(equalTo: categoryView.topAnchor, constant: -50),
            recipeImage.centerXAnchor.constraint(equalTo: categoryView.centerXAnchor),
            recipeImage.heightAnchor.constraint(equalToConstant: 100),
            recipeImage.widthAnchor.constraint(equalToConstant: 100),
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


