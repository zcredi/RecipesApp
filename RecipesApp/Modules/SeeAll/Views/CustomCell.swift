import UIKit
import Kingfisher

class CustomCell: UITableViewCell {
    // MARK: - Visual Components
    
    static let identifier = "CustomCell"
    
    private let ratingView: RatingView = {
        let ratingView = RatingView()
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.layer.cornerRadius = 10
        ratingView.clipsToBounds = true
        return ratingView
    }()
    
    
    private let mealNameLabel: UILabel = {
        let label = UILabel(text: "How to make yam & vegetable sauce at home", font: .poppinsBold16(), textColor: .white)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mealImage")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel(text: "9 Ingredients | 25 min", font: .poppinsRegular14(), textColor: .white)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Init
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    @available(*, unavailable)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        contentView.addSubview(mealImageView)
        contentView.addSubview(mealNameLabel)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(ratingView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mealImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            mealImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            mealImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mealImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            ratingView.leadingAnchor.constraint(equalTo: mealImageView.leadingAnchor, constant: 10),
            ratingView.topAnchor.constraint(equalTo: mealImageView.topAnchor, constant: 10),
            ratingView.heightAnchor.constraint(equalToConstant: 28),
            ratingView.widthAnchor.constraint(equalToConstant: 55),
            
            mealNameLabel.bottomAnchor.constraint(equalTo: ingredientsLabel.topAnchor, constant: -10),
            mealNameLabel.leadingAnchor.constraint(equalTo: mealImageView.leadingAnchor,constant: 10),
            mealNameLabel.trailingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: -10),

            
            ingredientsLabel.leadingAnchor.constraint(equalTo: mealImageView.leadingAnchor, constant: 10),
            ingredientsLabel.bottomAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: -20)
        ])
    }
    public func configure(withModelRecipe model: Recipe) {
        guard let url = URL(string: model.image) else { return }
        mealImageView.kf.setImage(with: url)
        mealNameLabel.text = model.name
        
        
    }
    
}

// MARK: - Public Methods

//    func configure(with viewModel: ViewModel) {
//        label.text = viewModel.text
//        label.font = viewModel.font
//        label.textColor = viewModel.textColor
//        emojiView.isHidden = (viewModel.emoji == nil)
//        emojiView.image = viewModel.emoji?.image(withSize: 40)
//    }

// MARK: - View Model

//extension CustomCell {
//    struct ViewModel {
//        let text: String
//        let font: UIFont
//        let textColor: UIColor
//        let emoji: String?
//
//        init(text: String,
//             font: UIFont = .systemFont(ofSize: 34, weight: .bold),
//             textColor: UIColor = .black,
//             emoji: String? = nil) {
//            self.text =  text
//            self.font = font
//            self.textColor = textColor
//            self.emoji = emoji
//        }
//}

