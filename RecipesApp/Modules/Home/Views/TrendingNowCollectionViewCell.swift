import UIKit
import Kingfisher

class TrendingNowCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrendingNowCell"
    
    private lazy var photoDish = UIImageView(image: "sending_m", cornerRadius: 16)
    
    private lazy var ratingContainerView = UIView(withBackgroundColor: UIColor(red: 0.19, green: 0.19, blue: 0.19, alpha: 0.5), cornerRadius: 8)
    
    private lazy var ratingImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var ratingLabel = UILabel(text: "4,5", font: UIFont(name: "Poppins-Bold", size: 14), textColor: .white, numberOfLines: 1)
    
    private lazy var titleDishLabel = UILabel(text: "How to sharwama at home", font: .poppinsBold16(), textColor: .black, numberOfLines: 0)
    
    private lazy var creatorStackView = UIStackView(axis: .horizontal, aligment: .center, spacing: 8)
    
    private lazy var creatorImageView = UIImageView(image: "sex", cornerRadius: 16)
    
    private lazy var creatorLabel = UILabel(text: "By Zeelicious foods", font: .poppinsRegular12(), textColor: UIColor(red: 0.57, green: 0.57, blue: 0.57, alpha: 1), numberOfLines: 1)
        
        
   
    
    func configureCell(with recipe: Recipe) {
        guard let recipeImageUrl = URL(string: recipe.image) else { return }
        photoDish.kf.setImage(with: recipeImageUrl)
        titleDishLabel.text = recipe.name
        
    }
    
    private func setupUI() {
        addSubviews(photoDish, titleDishLabel, creatorStackView)
        photoDish.addSubview(ratingContainerView)
        ratingContainerView.addSubviews(ratingImageView, ratingLabel)
        creatorStackView.addArrangedSubview(creatorImageView)
        creatorStackView.addArrangedSubview(creatorLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoDish.topAnchor.constraint(equalTo: topAnchor),
            photoDish.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoDish.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoDish.heightAnchor.constraint(equalToConstant: 180),
       
            ratingContainerView.topAnchor.constraint(equalTo: photoDish.topAnchor, constant: 8),
            ratingContainerView.leadingAnchor.constraint(equalTo: photoDish.leadingAnchor, constant: 8),
            
       
            ratingImageView.leadingAnchor.constraint(equalTo: ratingContainerView.leadingAnchor, constant: 8),
            ratingImageView.topAnchor.constraint(equalTo: ratingContainerView.topAnchor, constant: 6),
            ratingImageView.bottomAnchor.constraint(equalTo: ratingContainerView.bottomAnchor, constant: -6),
            
            ratingLabel.leadingAnchor.constraint(equalTo: ratingImageView.trailingAnchor, constant: 8),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingImageView.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingContainerView.trailingAnchor, constant: -8),
            
            
            titleDishLabel.topAnchor.constraint(equalTo: photoDish.bottomAnchor, constant: 12),
            titleDishLabel.leadingAnchor.constraint(equalTo: photoDish.leadingAnchor),
            titleDishLabel.trailingAnchor.constraint(equalTo: photoDish.trailingAnchor),
        
            creatorStackView.topAnchor.constraint(equalTo: titleDishLabel.bottomAnchor, constant: 8),
            creatorStackView.leadingAnchor.constraint(equalTo: titleDishLabel.leadingAnchor),
            creatorStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            creatorImageView.heightAnchor.constraint(equalToConstant: 32),
            creatorImageView.widthAnchor.constraint(equalTo: creatorImageView.heightAnchor),
        ])
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
