import AlertKit
import Kingfisher
import RealmSwift
import UIKit

// MARK: - RecipeDetailViewController

final class RecipeDetailViewController: UIViewController {
    private let realm = try! Realm()
    public var id: Int
    private let networkManager = NetworkManager()
    private let urlGenerator = URLGenerate()
    public var detailRecipeModel: DetailRecipeModel
    
    private var instruction: [Step]
    private var ingredients: [Ingredient]
    private var allIngredients: [Ingredient] = []
    private var selectedIngredients: Set<Int> = []
    
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
  
    private var recipeNameLabel = UILabel(font: UIFont.poppinsBold24(), textColor: UIColor.neutral100)
  
    private lazy var recipeImage: UIImageView = {
        let recipeImage = UIImageView()
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.image = UIImage(named: "recipeImage")
        recipeImage.layer.cornerRadius = 20
        recipeImage.clipsToBounds = true
        return recipeImage
    }()
  
    private lazy var ratingImage: UIImageView = {
        let ratingImage = UIImageView()
        ratingImage.contentMode = .scaleAspectFill
        ratingImage.image = UIImage(systemName: "star.fill")
        ratingImage.tintColor = .black
        return ratingImage
    }()
  
    private lazy var ratingLabel = UILabel(text: "4.5", font: UIFont.poppinsBold14(), textColor: UIColor.neutral100)
    private lazy var reviewsLabel = UILabel(text: "(300 reviews)", font: UIFont.poppinsRegular14(), textColor: UIColor.neutral50)
  
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
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private var ingredientCount = 0
  
    init(model: DetailRecipeModel, id: Int) {
        self.detailRecipeModel = model
        self.id = id
        self.ingredients = []
        self.instruction = []
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBarWithBackButton()
        createSaveRecipeBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupRecipeUI()
        checkObjectInRealm(id: id)
        navigationItem.title = "Preparation"
    }
    
    private func createSaveRecipeBarButton() {
        let saveRecipeButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveRecipeButtonTapped(_:)))
        navigationItem.rightBarButtonItem = saveRecipeButton
    }
    
    @IBAction func saveRecipeButtonTapped(_ sender: UIBarButtonItem) {
        let savedRecipe = SavedRecipeModel()
        
        switch sender.image {
        case UIImage(systemName: "bookmark"):
            sender.image = UIImage(systemName: "bookmark.fill")
            AlertKitAPI.present(title: "Saved to favorites", subtitle: nil, icon: .done, style: .iOS16AppleMusic, haptic: .success)
            
            savedRecipe.saveToRealm(id: id, image: detailRecipeModel.imageRecipe, title: detailRecipeModel.nameRecipe)
            
        case UIImage(systemName: "bookmark.fill"):
            sender.image = UIImage(systemName: "bookmark")
            AlertKitAPI.present(title: "Deleted from saved", subtitle: nil, icon: .error, style: .iOS16AppleMusic, haptic: .success)
            
            savedRecipe.deleteObjectFromRealm(id: id)
        default: break
        }
    }
  
    private func checkObjectInRealm(id: Int) {
        do {
            let objects = realm.objects(SavedRecipeModel.self).filter("id == \(id)")
            if !objects.isEmpty {
                navigationItem.rightBarButtonItem!.image = UIImage(systemName: "bookmark.fill")
            } else {
                navigationItem.rightBarButtonItem!.image = UIImage(systemName: "bookmark")
            }
        } catch {
            navigationItem.rightBarButtonItem!.image = UIImage(systemName: "bookmark")
            print("Error checking object in Realm: \(error)")
        }
    }

    
    private func setupRecipeUI() {
        guard let url = URL(string: detailRecipeModel.imageRecipe) else { return }
        
        self.recipeImage.kf.setImage(with: url)
        self.recipeNameLabel.text = self.detailRecipeModel.nameRecipe
        
        let instructionRequest = urlGenerator.request(endpoint: "recipes/" + "\(id)/analyzedInstructions", queryItems: [URLQueryItem(name: "stepBreakdown", value: "true")])
        networkManager.request(generator: instructionRequest) { (result: Swift.Result<[InformationIngradient], Error>) in
            switch result {
            case .success(let searched):
                guard !searched.isEmpty else {
                    let alert = UIAlertController(title: "Internet data did not arrive", message: "The API creators didn't take care of all the requests ", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "ОК", style: .default)
                    
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                    return
                }
                
                let instruction = searched[0].steps
                let ingredients = instruction[0].ingredients
                self.instruction = instruction
                self.ingredients = ingredients
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.updateTableViewHeight()
                }
                
                for info in searched {
                    for step in info.steps {
                        self.allIngredients.append(contentsOf: step.ingredients)
                    }
                }

                self.allIngredients = self.allIngredients.reduce([]) { acc, ingredient -> [Ingredient] in
                    if acc.contains(where: { $0.id == ingredient.id }) {
                        return acc
                    } else {
                        return acc + [ingredient]
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
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
        view.backgroundColor = UIColor.white
        addSubviews()
        setupLayout()
        configureRecipeNameLabel()
        configureRatingLabel()
        configureReviewsLabel()
        configureTableView()
    }
}

// MARK: - Setting

private extension RecipeDetailViewController {
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(recipeNameLabel)
        contentView.addSubview(recipeImage)
        contentView.addSubview(ratingStack)
        contentView.addSubview(tableView)
    }
  
    func configureRecipeNameLabel() {
        recipeNameLabel.text = """
        How to make Tasty Fish
        (point & Kill)
        """
        recipeNameLabel.numberOfLines = 2
    }
  
    func configureRatingLabel() {
        ratingLabel.adjustsFontSizeToFitWidth = false
    }
  
    func configureReviewsLabel() {
        reviewsLabel.textAlignment = .left
        reviewsLabel.adjustsFontSizeToFitWidth = false
    }
  
    func configureTableView() {
        tableView.register(InstructionCell.self, forCellReuseIdentifier: InstructionCell.identifier)
        tableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
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
            return instruction.count
        case 1:
            return allIngredients.count
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
        label.textColor = UIColor.neutral100
        label.font = UIFont.poppinsBold20()
    
        switch section {
        case 0:
            label.text = "Instructions"
            return label
        case 1:
            label.text = "Ingredients"
            let ingredientLabel = UILabel(text: "\(allIngredients.count) items", font: UIFont.poppinsRegular14(), textColor: UIColor.neutral50)
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
            let step = instruction[indexPath.row].step
            cell.stepLabel.text = step
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.identifier, for: indexPath) as! IngredientCell
            let ingredient = allIngredients[indexPath.row]
            let isSelected = selectedIngredients.contains(ingredient.id)
            cell.checkmark(isSelected: isSelected)
            cell.configure(ingredient: ingredient)
            return cell

        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let ingredient = allIngredients[indexPath.row]
            if selectedIngredients.contains(ingredient.id) {
                selectedIngredients.remove(ingredient.id)
            } else {
                selectedIngredients.insert(ingredient.id)
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
