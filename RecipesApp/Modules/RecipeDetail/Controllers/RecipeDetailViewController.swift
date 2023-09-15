import AlertKit
import Kingfisher
import UIKit

// MARK: - RecipeDetailViewController

final class RecipeDetailViewController: UIViewController {
    let recipeDetailViewModel = RecipeDetailViewModel()
    // MARK: - Private Property

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
  
    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
  
    private var recipeNameLabel = UILabel(font: UIFont.poppinsBold24(), textColor: UIColor(named: "blackWhite")!, numberOfLines: 2)
    
    private lazy var recipeImage = UIImageView(image: "recipeImage", cornerRadius: 20)
    
    
    private lazy var ratingImage: UIImageView = {
        let ratingImage = UIImageView()
        ratingImage.contentMode = .scaleAspectFill
        ratingImage.image = UIImage(systemName: "star.fill")
        ratingImage.tintColor = UIColor(named: "blackWhite")!
        return ratingImage
    }()
  
    private lazy var ratingLabel = UILabel(text: "4.5", font: UIFont.poppinsBold14(), textColor: UIColor(named: "blackWhite")!, numberOfLines: 1)
    private lazy var reviewsLabel = UILabel(text: "(300 reviews)", font: UIFont.poppinsRegular14(), textColor: UIColor(named: "blackWhite")!, textAligment: .left, numberOfLines: 2)
  
    private lazy var ratingStack: UIStackView = {
        let ratingStack = UIStackView(arrangedSubviews: [ratingImage, ratingLabel, reviewsLabel])
        ratingStack.axis = .horizontal
        ratingStack.distribution = .fillProportionally
        ratingStack.spacing = 1
        return ratingStack
    }()
  
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InstructionCell.self, forCellReuseIdentifier: InstructionCell.identifier)
        tableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.identifier)
        return tableView
    }()
    
    private var ingredientCount = 0
  
    init(recipe: String, image: String, id: Int) {
        self.recipeDetailViewModel.recipeName = recipe
        self.recipeDetailViewModel.recipeImage = image
        self.recipeDetailViewModel.id = id
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        setupNavigationBarWithBackButton()
        createSaveRecipeBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupRecipeUI()
        checkObjectInRealm()
        navigationItem.title = "Preparation"
    }
    
    private func createSaveRecipeBarButton() {
        let saveRecipeButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveRecipeButtonTapped(_:)))
        navigationItem.rightBarButtonItem = saveRecipeButton
    }
    
    @IBAction func saveRecipeButtonTapped(_ sender: UIBarButtonItem) {
        let imageRecipe = recipeDetailViewModel.recipeImage
        let titleRecipe = recipeDetailViewModel.recipeName
        switch sender.image {
        case UIImage(systemName: "bookmark"):
            sender.image = UIImage(systemName: "bookmark.fill")
            AlertKitAPI.present(title: "Saved to favorites", subtitle: nil, icon: .done, style: .iOS16AppleMusic, haptic: .success)
            
            recipeDetailViewModel.saveToRealm(id: recipeDetailViewModel.id, image: imageRecipe, title: titleRecipe)
            
        case UIImage(systemName: "bookmark.fill"):
            sender.image = UIImage(systemName: "bookmark")
            AlertKitAPI.present(title: "Deleted from saved", subtitle: nil, icon: .error, style: .iOS16AppleMusic, haptic: .success)
            
            recipeDetailViewModel.deleteObjectFromRealm(id: recipeDetailViewModel.id)
        default: break
        }
    }
  
    private func checkObjectInRealm() {
        recipeDetailViewModel.checkObjectInRealm {
            self.navigationItem.rightBarButtonItem!.image = UIImage(systemName: "bookmark.fill")
        } failureCompletion: {
            self.navigationItem.rightBarButtonItem!.image = UIImage(systemName: "bookmark")
        }
    }

    private func setupRecipeUI() {
        guard let url = URL(string: recipeDetailViewModel.recipeImage) else { return }
        
        self.recipeImage.kf.setImage(with: url)
        self.recipeNameLabel.text = self.recipeDetailViewModel.recipeName
        
        recipeDetailViewModel.fetchRecipe {
            self.tableView.reloadData()
            self.updateTableViewHeight()
        } failureCompletion: {
            let alert = UIAlertController(title: "Internet data did not arrive", message: "API KEY", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func updateTableViewHeight() {
        var totalHeight: CGFloat = 0.0
        for section in 0..<tableView.numberOfSections {
            totalHeight += tableView.rectForHeader(inSection: section).height
            totalHeight += tableView.rectForFooter(inSection: section).height
            for row in 0..<tableView.numberOfRows(inSection: section) {
                totalHeight += tableView.rectForRow(at: IndexPath(row: row, section: section)).height
            }
        }

        for constraint in tableView.constraints where constraint.firstAttribute == .height {
            constraint.isActive = false
        }
        tableView.heightAnchor.constraint(equalToConstant: totalHeight).isActive = true

        let totalContentHeight = totalHeight + recipeImage.frame.height + ratingStack.frame.height + recipeNameLabel.frame.height + 50
        for constraint in contentView.constraints where constraint.firstAttribute == .height {
            constraint.isActive = false
        }
        contentView.heightAnchor.constraint(equalToConstant: totalContentHeight).isActive = true
    }
}

// MARK: - Setting Views

private extension RecipeDetailViewController {
    func setupView() {
        addSubviews()
        setupLayout()
    }
}

// MARK: - Setting

private extension RecipeDetailViewController {
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(recipeNameLabel, recipeImage, ratingStack, tableView)
    }
}

// MARK: - Layuot

private extension RecipeDetailViewController {
    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        ratingStack.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
          
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
          
            recipeNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            recipeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            recipeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
          
            recipeImage.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 12),
            recipeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            recipeImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            recipeImage.heightAnchor.constraint(equalTo: recipeImage.widthAnchor, multiplier: 0.6),
          
            ratingStack.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 12),
            ratingStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ratingStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            ratingImage.heightAnchor.constraint(equalToConstant: 15),
            ratingImage.widthAnchor.constraint(equalToConstant: 15),
          
            tableView.topAnchor.constraint(equalTo: ratingStack.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension RecipeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return recipeDetailViewModel.instruction.count
        case 1:
            return recipeDetailViewModel.allIngredients.count
        default: break
        }
        return 0
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 70
        default:
            return 100
        }
    }
    
    
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.textColor = UIColor(named: "blackWhite")!
        label.font = UIFont.poppinsBold20()
    
        switch section {
        case 0:
            label.text = "Instructions"
            return label
        case 1:
            label.text = "Ingredients"
            let ingredientLabel = UILabel(text: "\(recipeDetailViewModel.allIngredients.count) items", font: UIFont.poppinsRegular14(), textColor: UIColor.neutral50, numberOfLines: 1)
            ingredientLabel.textAlignment = .right
            let stackView = UIStackView(arrangedSubviews: [label, ingredientLabel])
            stackView.spacing = 2
            stackView.distribution = .equalSpacing
            return stackView
        default:
            return label
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: InstructionCell.identifier, for: indexPath) as! InstructionCell
            let step = recipeDetailViewModel.instruction[indexPath.row].step
            cell.stepLabel.text = step
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.identifier, for: indexPath) as! IngredientCell
            let ingredient = recipeDetailViewModel.allIngredients[indexPath.row]
            let isSelected = recipeDetailViewModel.selectedIngredients.contains(ingredient.id)
            cell.checkmark(isSelected: isSelected)
            cell.configure(ingredient: ingredient)
            cell.backgroundColor = UIColor(named: "categoryColor")
            return cell

        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let ingredient = recipeDetailViewModel.allIngredients[indexPath.row]
            if recipeDetailViewModel.selectedIngredients.contains(ingredient.id) {
                recipeDetailViewModel.selectedIngredients.remove(ingredient.id)
            } else {
                recipeDetailViewModel.selectedIngredients.insert(ingredient.id)
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
