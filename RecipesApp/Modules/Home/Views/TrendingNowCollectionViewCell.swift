import UIKit
import Kingfisher

class TrendingNowCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrendingNowCell"
    
    private lazy var photoDish: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sending_m"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private lazy var ratingContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.19, green: 0.19, blue: 0.19, alpha: 0.5)
        view.layer.cornerRadius = 8
        view.layer.cornerCurve = .continuous
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var ratingImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel(text: "4,5", font: UIFont(name: "Poppins-Bold", size: 14), textColor: .white)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var saveView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var saveImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "bookmark")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleDishLabel: UILabel = {
        let label = UILabel(text: "How to sharwama at home", font: .poppinsBold16(), textColor: .black)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var creatorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    private lazy var creatorImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sex"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    
    private lazy var creatorLabel: UILabel = {
        let label = UILabel(text: "By Zeelicious foods", font: .poppinsRegular12(), textColor: UIColor(red: 0.57, green: 0.57, blue: 0.57, alpha: 1))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(photoDish)
        photoDish.addSubview(ratingContainerView)
        photoDish.addSubview(saveView)
        ratingContainerView.addSubview(ratingImageView)
        ratingContainerView.addSubview(ratingLabel)
        saveView.addSubview(saveImage)
        addSubview(titleDishLabel)
        addSubview(creatorStackView)
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
            
            saveView.heightAnchor.constraint(equalToConstant: 32),
            saveView.widthAnchor.constraint(equalToConstant: 32),
            saveView.trailingAnchor.constraint(equalTo: photoDish.trailingAnchor, constant: -8),
            saveView.centerYAnchor.constraint(equalTo: ratingContainerView.centerYAnchor),
       
            ratingImageView.leadingAnchor.constraint(equalTo: ratingContainerView.leadingAnchor, constant: 8),
            ratingImageView.topAnchor.constraint(equalTo: ratingContainerView.topAnchor, constant: 6),
            ratingImageView.bottomAnchor.constraint(equalTo: ratingContainerView.bottomAnchor, constant: -6),
            
            ratingLabel.leadingAnchor.constraint(equalTo: ratingImageView.trailingAnchor, constant: 8),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingImageView.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingContainerView.trailingAnchor, constant: -8),
            
            
            saveImage.centerYAnchor.constraint(equalTo: saveView.centerYAnchor),
            saveImage.centerXAnchor.constraint(equalTo: saveView.centerXAnchor),
        
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
    
    func configureCell(with recipe: InformationSearchRecipe) {
        guard let recipeImageUrl = URL(string: recipe.image) else { return }
        photoDish.kf.setImage(with: recipeImageUrl)
        titleDishLabel.text = recipe.title
        
    }
}
