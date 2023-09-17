import UIKit

class IngredientsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "IngredientsCollectionViewCell"
    private lazy var itemLabel = CreateRecipeTextField()
    private lazy var quantityLabel = CreateRecipeTextField()
    
    public lazy var deleteItemButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus.circle")?.withTintColor(UIColor(named: "blackWhite")!, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    private func setupViews() {
        addSubviews(itemLabel, quantityLabel, deleteItemButton)
        itemLabel.layer.borderColor = UIColor.neutral20.cgColor
        quantityLabel.layer.borderColor = UIColor.neutral20.cgColor
    }
    
    func configureCell(model: IngredientsItemModel) {
        itemLabel.text = "   " + model.itemName
        quantityLabel.text = "   " + model.quantity
    }
    
    //MARK: - setConstraints
    
    private func setConstraints() {
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteItemButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // itemLabel constraints
            itemLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemLabel.heightAnchor.constraint(equalToConstant: 35.0),
            itemLabel.widthAnchor.constraint(equalToConstant: 180),
            
            // quantityLabel constraints
            quantityLabel.leadingAnchor.constraint(equalTo: itemLabel.trailingAnchor, constant: 15),
            quantityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            quantityLabel.heightAnchor.constraint(equalToConstant: 35.0),
            quantityLabel.widthAnchor.constraint(equalToConstant: 100),
            
            // deleteItemButton constraints
            deleteItemButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 12.0),
            deleteItemButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteItemButton.heightAnchor.constraint(equalToConstant: 25),
            deleteItemButton.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
