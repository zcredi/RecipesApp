import UIKit

class FooterView: UIView {
    private lazy var ingredientsLabel = UILabel(text: "Ingredients", font: .poppinsBold20(), textColor: UIColor(named: "blackWhite")!, numberOfLines: 1)
    
    private lazy var ingredientsArray: [IngredientsItemModel] = [
        IngredientsItemModel(itemName: "Pasta", quantity: "250gr"),
        IngredientsItemModel(itemName: "Green Beans", quantity: "150gr"),
    ]
    
    private lazy var itemTextField = CreateRecipeTextField()
    private lazy var quantityTextField = CreateRecipeTextField()
    
    private lazy var addNewItemButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle")?.withTintColor(UIColor(named: "blackWhite")!, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(addNewItemButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(IngredientsCollectionViewCell.self, forCellWithReuseIdentifier: IngredientsCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        setDelegates()
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews(ingredientsLabel, itemTextField, quantityTextField, addNewItemButton, itemCollectionView)
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
            ingredientsLabel.topAnchor.constraint(equalTo: topAnchor),
            ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
        ])
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemCollectionView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 10),
            itemCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemCollectionView.heightAnchor.constraint(equalToConstant: 100),
        ])
        itemTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemTextField.topAnchor.constraint(equalTo: itemCollectionView.bottomAnchor, constant: 10),
            itemTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemTextField.heightAnchor.constraint(equalToConstant: 35),
            itemTextField.widthAnchor.constraint(equalToConstant: 180)
        ])
        quantityTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityTextField.leadingAnchor.constraint(equalTo: itemTextField.trailingAnchor, constant: 15),
            quantityTextField.centerYAnchor.constraint(equalTo: itemTextField.centerYAnchor),
            quantityTextField.heightAnchor.constraint(equalToConstant: 35),
            quantityTextField.widthAnchor.constraint(equalToConstant: 100)
        ])
        addNewItemButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addNewItemButton.leadingAnchor.constraint(equalTo: quantityTextField.trailingAnchor, constant: 12),
            addNewItemButton.centerYAnchor.constraint(equalTo: itemTextField.centerYAnchor),
        ])
    }
}

//MARK: - UICollectionViewDelegate

extension FooterView: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FooterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 45)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientsCollectionViewCell.identifier, for: indexPath) as! IngredientsCollectionViewCell
        cell.configureCell(model: ingredientsArray[indexPath.item])
        cell.deleteItemButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return cell
    }
}
