import UIKit
import Kingfisher

class RecentRecipeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecentRecipeCell"
    
    private lazy var recipeImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "sex"))
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var recipeLabel: UILabel = {
        let label = UILabel(text: "Kelewele Ghanian Recipe", font: UIFont.poppinsBold14(), textColor: .black)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var creatorLabel: UILabel = {
        let label = UILabel(text: "By Zeelicious Foods", font: UIFont.poppinsRegular10(), textColor: .lightGray)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public func configureCell(with recipe: PopularCategoryInfo) {
        guard let recipeImageUrl = URL(string: recipe.image) else { return }
        recipeImage.kf.setImage(with: recipeImageUrl)
        recipeLabel.text = recipe.title
        creatorLabel.text = "By Zeelicious Foods"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(recipeImage)
        addSubview(recipeLabel)
        addSubview(creatorLabel)
        
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
