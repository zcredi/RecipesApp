import UIKit

// MARK: - RecipeDetailViewController
final class RecipeDetailViewController: UIViewController {
  
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
    recipeImage.image = UIImage(named: "recipeImage")
    recipeImage.layer.cornerRadius = 20
    recipeImage.clipsToBounds = true
    return recipeImage
  }()
  
  private lazy var ratingImage: UIImageView = {
    let ratingImage = UIImageView()
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
  
  private  let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
    tableView.backgroundColor = .white
    return tableView
  }()
  
  private var ingredientCount = 0
  
  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
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
  func setupLayout() {
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
      contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
      
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
      
      ratingImage.heightAnchor.constraint(equalToConstant: 12),
      ratingImage.widthAnchor.constraint(equalToConstant: 12),
      ratingLabel.widthAnchor.constraint(equalToConstant: 25),
      
      tableView.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 5),
      tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
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
      return 5
    case 1:
      return 10
    default:
      return 1
    }
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
      let ingredientLabel = UILabel(text: "\(ingredientCount) items", font: UIFont.poppinsRegular14(), textColor: UIColor.neutral50)
      ingredientLabel.textAlignment = .right
      let stackView = UIStackView(arrangedSubviews: [label, ingredientLabel])
      stackView.distribution = .fillEqually
      return stackView
    default:
      return label
    }
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: InstructionCell.identifier, for: indexPath) as? InstructionCell else { return UITableViewCell() }
      return cell
    case 1:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.identifier, for: indexPath) as? IngredientCell else { return UITableViewCell() }
      cell.checkmark()
      return cell
    default:
      return UITableViewCell()
    }
    
  }
}
