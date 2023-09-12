import UIKit

class FooterView: UIView {
    enum Constants {
        static let textFieldHeight: CGFloat = 35.0
        static let textFieldCorner: CGFloat = 10.0
        static let textFieldLeadingSpacing: CGFloat = 16.0
        static let quantityTextFieldLeadingSpacing: CGFloat = 12.0
        static let itemTextFieldWidth: CGFloat = 164.0
        static let quantityTextFieldWidth: CGFloat = 115.0
        static let collectionViewId: String = "collectionViewId"
    }
    
    private lazy var ingredientsArray: [IngredientsItemModel] = [
        IngredientsItemModel(itemName: "Pasta", quantity: "250gr"),
        IngredientsItemModel(itemName: "Green Beans", quantity: "150gr"),
    ]
    
    private lazy var ingredientsLabel = UILabel(text: "Ingredients", font: .poppinsBold20(), textColor: .neutral100, numberOfLines: 1)
    
    private lazy var itemTextField = CreateRecipeTextField()
    
    private lazy var quantityTextField = CreateRecipeTextField()
    
    private lazy var addNewItemButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "addNewItemButtonImage")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(addNewItemButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        return collectionView
    }()
    
    private lazy var ingredientsNewItem: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plusIngredients")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("Add new Ingredient", for: .normal)
        button.tintColor = .neutral100
        button.titleLabel?.font = .poppinsBold16()
        button.addTarget(self, action: #selector(addNewIngredientTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        itemCollectionView.register(IngredientsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.collectionViewId)
        setupViews()
        setConstraints()
        setDelegates()
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews(ingredientsLabel, itemTextField, quantityTextField, addNewItemButton, itemCollectionView, ingredientsNewItem)
        itemTextField.layer.borderColor = UIColor.neutral20.cgColor
        quantityTextField.layer.borderColor = UIColor.neutral20.cgColor
    }
    
    private func setDelegates() {
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
    }
    
    @objc
    private func addNewItemButtonTapped() {
        ingredientsArray.append(IngredientsItemModel(
            itemName: itemTextField.text ?? "",
            quantity: quantityTextField.text ?? "")
        )
        itemCollectionView.reloadData()
    }
    
    @objc
    public func deleteButtonTapped() {
        print("delete tapped")
        guard let selectedItemIndex = itemCollectionView.indexPathsForSelectedItems?.first else {
                // Нет выбранного элемента, необходимо обработать соответствующим образом
                return
            }
        
            ingredientsArray.remove(at: selectedItemIndex.item)
            itemCollectionView.reloadData()
    }
    
    @objc
    private func addNewIngredientTapped() {
        print("add")
    }
    
    private func addGesture() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        addGestureRecognizer(tapScreen)
        
        let swipeScreen = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboard))
        swipeScreen.cancelsTouchesInView = false
        addGestureRecognizer(swipeScreen)
    }
    
    @objc
    private func hideKeyboard() {
        endEditing(true)
    }
}

extension FooterView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
        ])
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemCollectionView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 8),
            itemCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            itemCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            itemCollectionView.heightAnchor.constraint(equalToConstant: 2.0*(Constants.textFieldHeight+16)+16)
        ])
        itemTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemTextField.topAnchor.constraint(equalTo: itemCollectionView.bottomAnchor, constant: 8),
            itemTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            itemTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            itemTextField.widthAnchor.constraint(equalToConstant: Constants.itemTextFieldWidth)
        ])
        quantityTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityTextField.leadingAnchor.constraint(equalTo: itemTextField.trailingAnchor, constant: Constants.quantityTextFieldLeadingSpacing),
            quantityTextField.centerYAnchor.constraint(equalTo: itemTextField.centerYAnchor),
            quantityTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            quantityTextField.widthAnchor.constraint(equalToConstant: Constants.quantityTextFieldWidth)
        ])
        addNewItemButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addNewItemButton.leadingAnchor.constraint(equalTo: quantityTextField.trailingAnchor, constant: Constants.quantityTextFieldLeadingSpacing),
            addNewItemButton.centerYAnchor.constraint(equalTo: itemTextField.centerYAnchor),
        ])
        
        ingredientsNewItem.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientsNewItem.topAnchor.constraint(equalTo: itemTextField.bottomAnchor, constant: 10),
            ingredientsNewItem.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
        ])
    }
}

//MARK: - UICollectionViewDelegate

extension FooterView: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FooterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 45 + 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
}

//MARK: - UICollectionViewDataSource

extension FooterView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ingredientsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewId, for: indexPath) as! IngredientsCollectionViewCell
        cell.configureCell(model: ingredientsArray[indexPath.item])
        cell.deleteItemButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return cell
    }
}
