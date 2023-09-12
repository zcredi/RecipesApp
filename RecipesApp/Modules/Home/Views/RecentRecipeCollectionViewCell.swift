import UIKit
import Kingfisher

class RecentRecipeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecentRecipeCell"
    
    private lazy var recipeImage = UIImageView(image: "sex", cornerRadius: 10)
    private lazy var recipeLabel = UILabel(text: "Kelewele Ghanian Recipe", font: UIFont.poppinsBold12(), textColor: .black, textAligment: .left, numberOfLines: 0)
    private lazy var creatorLabel = UILabel(text: "By Zeelicious Foods", font: UIFont.poppinsRegular10(), textColor: .lightGray, textAligment: .left, numberOfLines: 1)
      
    
    public func configureCell(with recipe: RecentRecipeModel) {
        guard let recipeImageUrl = URL(string: recipe.imageURL) else { return }
        recipeImage.kf.setImage(with: recipeImageUrl)
        recipeLabel.text = recipe.title
        creatorLabel.text = "By Zeelicious Foods"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(recipeImage, recipeLabel, creatorLabel)
        
        NSLayoutConstraint.activate([
            recipeImage.heightAnchor.constraint(equalToConstant: 150),
            recipeImage.widthAnchor.constraint(equalToConstant: 150),
            recipeImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            recipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 10),
            
            
            creatorLabel.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor, constant: 10),
            creatorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            creatorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
