import UIKit
import Kingfisher
class HomeViewController: UIViewController {
    private let networkManager = NetworkManager()
    private let urlGenerator = URLGenerate()
    private var trendingNow: [Recipe] = []
    private var popularCategoryTagArray: [PopularCategoryInfo] = []
    private var recentRecipeArray: [PopularCategoryInfo] = []
    private let popularCategoryArray = ["Breakfast", "Dessert", "Salad", "Appetizer", "Soup", "Drink", "Beverage", "Sauce", "Fingerfood", "Snack"]
    private var selectedIndexPathForButtonCollectionTag: IndexPath?
    private var popularCreatorsArray = [
        "Jamie Oliver",
        "Yotam Ottolenghi",
        "Anthony Bourdain",
        "Nusret Gökçe",
        "Gordon Ramsay",
        "Massimo Bottura",
        "Christina Tosi",
        "Sanjeev Kapoor",
        "Joël Robuchon",
        "Alain Ducasse",
        "Ferran Adrià",
        "Thomas Keller",
        "Daniel Humm",
        "Martha Stewart"
    ]
    
    private lazy var searchRecipe: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "Search Recipes"
        return sc
    }()
    
    private lazy var homeScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.poppinsBold14()
        button.setTitle("See All →", for: .normal)
        button.addTarget(self, action: #selector(trendingNowSeeAllButtonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var popularCategoryLabel: UILabel = {
        let label = UILabel(text: "Popular Category", font: UIFont.poppinsBold20(), textColor: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var recentRecipeLabel: UILabel = {
        let label = UILabel(text: "Recent Recipe", font: UIFont.poppinsBold20(), textColor: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trendingNowLabel: UILabel = {
        let label = UILabel(text: "Trending now 🔥", font: UIFont.poppinsBold20(), textColor: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var popularCreatorsLabel: UILabel = {
        let label = UILabel(text: "Popular Creators", font: UIFont.poppinsBold20(), textColor: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trendingNowCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 320, itemHeight: 250)
        collectionView.register(TrendingNowCollectionViewCell.self, forCellWithReuseIdentifier: TrendingNowCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var popularCategoryTagCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 90, itemHeight: 40)
        collectionView.register(SwitchPopularCategoryCollectionViewCell.self, forCellWithReuseIdentifier: SwitchPopularCategoryCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var popularCategoryCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 170, itemHeight: 200)
        collectionView.register(PopularCategoryCollectionViewCell.self, forCellWithReuseIdentifier: PopularCategoryCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var recentRecipeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 150, itemHeight: 250)
        collectionView.register(RecentRecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecentRecipeCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var popularCreatorsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 120, itemHeight: 150)
        collectionView.register(PopularCreatorsCollectionViewCell.self, forCellWithReuseIdentifier: PopularCreatorsCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchRecipe
        callNetworking()
        selectedIndexPathForButtonCollectionTag = IndexPath(row: 0, section: 0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupNavigationBar()
        setupUI()
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel(text: "Get amazing recipe for cooking", font: UIFont.poppinsRegular20(), textColor: .black)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
    }
    
    @IBAction func trendingNowSeeAllButtonPressed(_ sender: UIButton) {
        print("Button pressed!!!")
        let seeAllViewController = SeeAllViewController()
        navigationController?.pushViewController(seeAllViewController, animated: true)
    }
    
    // MARK: - CallNetworking Method

    private func callNetworking() {
        let trendingNowRequest = urlGenerator.request(endpoint: "food/search", queryItems: [URLQueryItem(name: "limitLicense", value: "true"), URLQueryItem(name: "limit", value: "10")])
        let popularCategoryRequest = urlGenerator.request(endpoint: "recipes/complexSearch", queryItems: [URLQueryItem(name: "type", value: "breakfast"), URLQueryItem(name: "addRecipeInformation", value: "true")])
        let recentRecipeRequest = urlGenerator.request(endpoint: "recipes/complexSearch", queryItems: [URLQueryItem(name: "type", value: "dessert"), URLQueryItem(name: "addRecipeInformation", value: "true")])
        
        networkManager.request(generator: trendingNowRequest) { (result: Swift.Result<SearchResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let searched):
                    self.trendingNow = searched.searchResults[0].results
                    self.trendingNowCollectionView.reloadData()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
        
        networkManager.request(generator: popularCategoryRequest) { (result: Swift.Result<PopularCategory, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let searched):
                    self.popularCategoryTagArray = searched.results
                    self.popularCategoryCollectionView.reloadData()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
        
        networkManager.request(generator: recentRecipeRequest) { (result: Swift.Result<PopularCategory, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let searched):
                    self.recentRecipeArray = searched.results
                    self.recentRecipeCollectionView.reloadData()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }

    // MARK: - SetupUI Method

    private func setupUI() {
        view.addSubview(homeScrollView)
        homeScrollView.addSubviews(trendingNowLabel, seeAllButton, trendingNowCollectionView, popularCategoryLabel, popularCategoryTagCollectionView, popularCategoryCollectionView, recentRecipeLabel, recentRecipeCollectionView, popularCreatorsLabel, popularCreatorsCollectionView)
        
        NSLayoutConstraint.activate([
            homeScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            homeScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            trendingNowLabel.topAnchor.constraint(equalTo: homeScrollView.topAnchor, constant: 10),
            trendingNowLabel.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor, constant: 15),
            
            seeAllButton.topAnchor.constraint(equalTo: homeScrollView.topAnchor, constant: 10),
            seeAllButton.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor, constant: -15),
            
            trendingNowCollectionView.topAnchor.constraint(equalTo: homeScrollView.topAnchor, constant: 50),
            trendingNowCollectionView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            trendingNowCollectionView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            trendingNowCollectionView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),
            trendingNowCollectionView.heightAnchor.constraint(equalToConstant: 260),
            
            popularCategoryLabel.topAnchor.constraint(equalTo: trendingNowCollectionView.bottomAnchor, constant: 30),
            popularCategoryLabel.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor, constant: 15),
            
            popularCategoryTagCollectionView.topAnchor.constraint(equalTo: popularCategoryLabel.bottomAnchor, constant: 20),
            popularCategoryTagCollectionView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            popularCategoryTagCollectionView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            popularCategoryTagCollectionView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),
            popularCategoryTagCollectionView.heightAnchor.constraint(equalToConstant: 40),
            
            popularCategoryCollectionView.topAnchor.constraint(equalTo: popularCategoryTagCollectionView.bottomAnchor, constant: 20),
            popularCategoryCollectionView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            popularCategoryCollectionView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            popularCategoryCollectionView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),
            popularCategoryCollectionView.heightAnchor.constraint(equalToConstant: 300),
            
            recentRecipeLabel.topAnchor.constraint(equalTo: popularCategoryCollectionView.bottomAnchor, constant: 20),
            recentRecipeLabel.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor, constant: 15),
            
            recentRecipeCollectionView.topAnchor.constraint(equalTo: recentRecipeLabel.bottomAnchor, constant: 10),
            recentRecipeCollectionView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            recentRecipeCollectionView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            recentRecipeCollectionView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),
            recentRecipeCollectionView.heightAnchor.constraint(equalToConstant: 300),
            
            popularCreatorsLabel.topAnchor.constraint(equalTo: recentRecipeCollectionView.bottomAnchor, constant: 20),
            popularCreatorsLabel.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor, constant: 15),
            
            popularCreatorsCollectionView.topAnchor.constraint(equalTo: popularCreatorsLabel.bottomAnchor, constant: 10),
            popularCreatorsCollectionView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            popularCreatorsCollectionView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            popularCreatorsCollectionView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),
            popularCreatorsCollectionView.heightAnchor.constraint(equalToConstant: 200),
            popularCreatorsCollectionView.bottomAnchor.constraint(equalTo: homeScrollView.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case trendingNowCollectionView: return trendingNow.count
        case popularCategoryCollectionView: return popularCategoryTagArray.count
        case popularCategoryTagCollectionView: return popularCategoryArray.count
        case recentRecipeCollectionView: return recentRecipeArray.count
        case popularCreatorsCollectionView: return popularCreatorsArray.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case trendingNowCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingNowCollectionViewCell.identifier, for: indexPath) as! TrendingNowCollectionViewCell
            let correctIndexPath = trendingNow[indexPath.row]
            cell.configureCell(with: correctIndexPath)
            return cell
        case popularCategoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCategoryCollectionViewCell.identifier, for: indexPath) as! PopularCategoryCollectionViewCell
            let correctIndexPath = popularCategoryTagArray[indexPath.row]
            cell.configureCell(with: correctIndexPath)
            return cell
        case popularCategoryTagCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwitchPopularCategoryCollectionViewCell.identifier, for: indexPath) as! SwitchPopularCategoryCollectionViewCell
            cell.delegate = self
            let category = popularCategoryArray[indexPath.row]
            cell.configureCell(with: category)
            
            if indexPath == selectedIndexPathForButtonCollectionTag {
                cell.toggleButtonState()
            } else {
                cell.resetButtonState()
            }
            
            return cell
        case recentRecipeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentRecipeCollectionViewCell.identifier, for: indexPath) as! RecentRecipeCollectionViewCell
            let correctIndexPath = recentRecipeArray[indexPath.row]
            cell.configureCell(with: correctIndexPath)
            return cell
            
        case popularCreatorsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCreatorsCollectionViewCell.identifier, for: indexPath) as! PopularCreatorsCollectionViewCell
            let correctIndexPath = popularCreatorsArray[indexPath.row]
            cell.configureCell(with: correctIndexPath)
            return cell
        default: break
        }
        fatalError("Unknown collection view cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case trendingNowCollectionView:
            let currentCellID = trendingNow[indexPath.row].id
            let recipeName = trendingNow[indexPath.row].name
            let recipeImage = trendingNow[indexPath.row].image
            let detailRecipeModel = DetailRecipeModel(nameRecipe: recipeName, imageRecipe: recipeImage)
            
            
            let vc = RecipeDetailViewController(model: detailRecipeModel, id: currentCellID)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case popularCategoryCollectionView:
            let currentCellID = popularCategoryTagArray[indexPath.row].id
            let recipeName = popularCategoryTagArray[indexPath.row].title
            let recipeImage = popularCategoryTagArray[indexPath.row].image
            let detailRecipeModel = DetailRecipeModel(nameRecipe: recipeName, imageRecipe: recipeImage)
            
            
            let vc = RecipeDetailViewController(model: detailRecipeModel, id: currentCellID)
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        case recentRecipeCollectionView:
            let currentCellID = recentRecipeArray[indexPath.row].id
            let recipeName = recentRecipeArray[indexPath.row].title
            let recipeImage = recentRecipeArray[indexPath.row].image
            let detailRecipeModel = DetailRecipeModel(nameRecipe: recipeName, imageRecipe: recipeImage)
            
            
            let vc = RecipeDetailViewController(model: detailRecipeModel, id: currentCellID)
            self.navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
}

// I know that there is a delegate method to make the cell clicks work, but I wanted to separate that logic out for the reason that it's easier for me to understand the code that way) by: @fullzoom

extension HomeViewController: SwitchPopularCategoryCellDelegate {
    func didTapButton(in cell: SwitchPopularCategoryCollectionViewCell) {
        if let previousSelectedIndexPath = selectedIndexPathForButtonCollectionTag,
           let previousCell = popularCategoryTagCollectionView.cellForItem(at: previousSelectedIndexPath) as? SwitchPopularCategoryCollectionViewCell
        {
            previousCell.resetButtonState()
        }
        
        if let currentSelectedIndexPath = popularCategoryTagCollectionView.indexPath(for: cell) {
            selectedIndexPathForButtonCollectionTag = currentSelectedIndexPath
            cell.toggleButtonState()
            let request = urlGenerator.request(endpoint: "recipes/complexSearch", queryItems: [URLQueryItem(name: "type", value: popularCategoryArray[currentSelectedIndexPath.row].lowercased()), URLQueryItem(name: "addRecipeInformation", value: "true")])
            
            networkManager.request(generator: request) { (result: Swift.Result<PopularCategory, Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let searched):
                        self.popularCategoryTagArray = searched.results
                        self.popularCategoryCollectionView.reloadData()
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
            }
        }
    }
}
