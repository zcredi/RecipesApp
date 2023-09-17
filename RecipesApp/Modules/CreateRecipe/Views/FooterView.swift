import UIKit

class FooterView: UIView {
    private lazy var ingredientsLabel = UILabel(text: "Ingredients", font: .poppinsBold20(), textColor: UIColor(named: "blackWhite")!, numberOfLines: 1)
    
    lazy var ingredientsArray: [IngredientsItemModel] = [
        IngredientsItemModel(itemName: "Pasta", quantity: "250gr"),
        IngredientsItemModel(itemName: "Green Beans", quantity: "150gr"),
    ]
    
    private lazy var itemTextField = CreateRecipeTextField()
    private lazy var quantityTextField = CreateRecipeTextField()
    
    private lazy var addNewItemButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle")?.withTintColor(UIColor(named: "blackWhite")!, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(addNewItemButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(IngredientsCollectionViewCell.self, forCellWithReuseIdentifier: IngredientsCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews(ingredientsLabel, itemTextField, quantityTextField, addNewItemButton, itemCollectionView)
        itemTextField.layer.borderColor = UIColor.neutral20.cgColor
        quantityTextField.layer.borderColor = UIColor.neutral20.cgColor
    }
    
    @IBAction func addNewItemButtonTapped(_ sender: UIButton) {
        if let item = itemTextField.text, !item.isEmpty,
           let quantity = quantityTextField.text, !quantity.isEmpty
        {
            ingredientsArray.append(IngredientsItemModel(
                itemName: item,
                quantity: quantity))
            itemCollectionView.reloadData()
        }
        itemTextField.text = ""
        quantityTextField.text = ""
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        print("hello")
        guard let cell = sender.superview as? IngredientsCollectionViewCell,
              let indexPath = itemCollectionView.indexPath(for: cell),
              indexPath.item < ingredientsArray.count else {
            return
        }
        ingredientsArray.remove(at: indexPath.item)
        itemCollectionView.deleteItems(at: [indexPath])
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
            itemTextField.widthAnchor.constraint(equalToConstant: 180),
        ])
        quantityTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityTextField.leadingAnchor.constraint(equalTo: itemTextField.trailingAnchor, constant: 15),
            quantityTextField.centerYAnchor.constraint(equalTo: itemTextField.centerYAnchor),
            quantityTextField.heightAnchor.constraint(equalToConstant: 35),
            quantityTextField.widthAnchor.constraint(equalToConstant: 100),
        ])
        addNewItemButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addNewItemButton.leadingAnchor.constraint(equalTo: quantityTextField.trailingAnchor, constant: 12),
            addNewItemButton.centerYAnchor.constraint(equalTo: itemTextField.centerYAnchor),
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension FooterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ingredientsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientsCollectionViewCell.identifier, for: indexPath) as! IngredientsCollectionViewCell
        cell.configureCell(model: ingredientsArray[indexPath.item])
        cell.deleteItemButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FooterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
