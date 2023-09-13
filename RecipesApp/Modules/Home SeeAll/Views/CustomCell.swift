import UIKit
import Kingfisher

class CustomCell: UITableViewCell {
    // MARK: - Visual Components
    static let identifier = "CustomCell"
    
    private let ratingView = RatingView()
    private let mealNameLabel = UILabel(text: "How to make yam & vegetable sauce at home", font: .poppinsBold16(), textColor: .white, textAligment: .left, numberOfLines: 0)
    private let mealImageView = UIImageView(image: "mealImage", cornerRadius: 12)
    private let ingredientsLabel = UILabel(text: "9 Ingredients | 25 min", font: .poppinsRegular14(), textColor: .white, textAligment: .left,  numberOfLines: 0)
    
    
    // MARK: - Private Methods
    
    private func setupViews() {
        contentView.addSubviews(mealImageView, mealNameLabel, ingredientsLabel, ratingView)
        setupConstraints()
    }
    
    public func configure(withModelRecipe model: Recipe) {
        guard let url = URL(string: model.image) else { return }
        mealImageView.kf.setImage(with: url)
        mealNameLabel.text = model.name
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
    
    @available(*, unavailable)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
