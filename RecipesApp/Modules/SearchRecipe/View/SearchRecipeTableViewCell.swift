import UIKit
import Kingfisher

class SearchRecipeTableViewCell: UITableViewCell {
    
    static let identifier = "SearchRecipeTableViewCell"
    private lazy var recipeImage = UIImageView(image: "sex", cornerRadius: 10)
    
    private lazy var recipeName = UILabel(text: "How to sharwama at home", font: .poppinsBold14(), textColor: UIColor(named: "blackWhite")!, numberOfLines: 0)
    
    
    public func configure(image: String, title: String) {
        guard let urlString = URL(string: image) else { return }
        recipeImage.kf.setImage(with: urlString)
        recipeName.text = title
    }
    
    
    private func setupUI() {
        addSubviews(recipeImage, recipeName)
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: topAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            recipeImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            recipeImage.heightAnchor.constraint(equalToConstant: 200),
            
            recipeName.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 10),
            recipeName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            recipeName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
