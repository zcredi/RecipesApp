import UIKit
import Kingfisher

class PopularCategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "PopularCategoryCell"
    
    private lazy var categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var recipeImage: UIImageView = {
        let image = UIImageView.init(image: UIImage(named: "sex"))
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 50
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    private lazy var recipeLabel: UILabel = {
        let label = UILabel(text: "Chicken and Vegetable wrap", font: UIFont.poppinsBold14(), textColor: .black)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currentTime: UILabel = {
        let label = UILabel(text: "5 Mins", font: UIFont.poppinsBold12(), textColor: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel(text: "Time", font: UIFont.poppinsRegular12(), textColor: .systemGray)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public func configureCell(with recipe: PopularCategoryInfo) {
        guard let recipeImageUrl = URL(string: recipe.image) else { return }
        recipeImage.kf.setImage(with: recipeImageUrl)
        recipeLabel.text = recipe.title
        currentTime.text = "\(recipe.readyInMinutes) Mins"
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryView)
        categoryView.addSubview(currentTime)
        categoryView.addSubview(timeLabel)
        categoryView.addSubview(recipeLabel)
        addSubview(recipeImage)
        
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


