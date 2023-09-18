import UIKit

// MARK: - MyRecipesCell

final class MyRecipesCell: UITableViewCell {
    static let identifier = "MyRecipesCell"
  
    lazy var photoImageView = RecipeImageView(frame: .zero)
        
  
    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setupCell()
        layoutUI()
    }
  
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: - Private Methods

    private func setupCell() {
        selectionStyle = .none
        contentView.addSubviews(photoImageView)
    }
    
    func setupCell(model: CreateRecipeModel) {
        guard let url = URL(string: model.image) else { return }
        photoImageView.kf.setImage(with: url)
        photoImageView.recipeNameLabel.text = model.title
        photoImageView.cookingTime.text = model.cookTime
        photoImageView.ingredientsLabel.text = "\(model.ingredients.count) ingredients"
    }
  
    // MARK: - Layout

    private func layoutUI() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      
            photoImageView.heightAnchor.constraint(equalToConstant: 200),
     
        ])
    }
}
