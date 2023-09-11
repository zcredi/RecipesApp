import UIKit
import RealmSwift


class HomeViewController: UIViewController {
    private let networkManager = NetworkManager()
    private let urlGenerator = URLRequestGeneratore()
    var uiSetupCompleted = false
    private let realm = try! Realm()
    
    private var trendingNow: [Recipe] = []
    private var popularCategoryTagArray: [PopularCategoryInfo] = []
    var recentRecipes: [RecentRecipeModel] = []
    private let popularCategoryArray = ["Breakfast", "Dessert", "Salad", "Appetizer", "Soup", "Drink", "Beverage", "Sauce", "Bread", "Marinade", "Fingerfood", "Snack"]
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
    
//    private lazy var searchRecipe: UISearchController = {
//        let sc = UISearchController(searchResultsController: nil)
//        sc.definesPresentationContext = true
//        sc.searchBar.placeholder = "Search Recipes"
//        sc.searchBar.delegate = self
//        return sc
//    }()
    
    lazy var homeScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.poppinsBold14()
        button.setTitle("See All →", for: .normal)
        button.addTarget(self, action: #selector(trendingNowSeeAllButtonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var popularCategoryLabel: UILabel = {
        let label = UILabel(text: "Popular Category", font: UIFont.poppinsBold20(), textColor: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var recentRecipeLabel: UILabel = {
        let label = UILabel(text: "Recent Recipe", font: UIFont.poppinsBold20(), textColor: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var trendingNowLabel: UILabel = {
        let label = UILabel(text: "Trending now 🔥", font: UIFont.poppinsBold20(), textColor: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var popularCreatorsLabel: UILabel = {
        let label = UILabel(text: "Popular Creators", font: UIFont.poppinsBold20(), textColor: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var trendingNowCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 320, itemHeight: 250)
        collectionView.register(TrendingNowCollectionViewCell.self, forCellWithReuseIdentifier: TrendingNowCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var popularCategoryTagCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 90, itemHeight: 40)
        collectionView.register(SwitchPopularCategoryCollectionViewCell.self, forCellWithReuseIdentifier: SwitchPopularCategoryCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var popularCategoryCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 170, itemHeight: 200)
        collectionView.register(PopularCategoryCollectionViewCell.self, forCellWithReuseIdentifier: PopularCategoryCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var recentRecipeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 150, itemHeight: 250)
        collectionView.register(RecentRecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecentRecipeCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var popularCreatorsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 120, itemHeight: 150)
        collectionView.register(PopularCreatorsCollectionViewCell.self, forCellWithReuseIdentifier: PopularCreatorsCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        navigationItem.searchController = searchRecipe
        callNetworking()
        loadRecentRecipesFromRealm()
        selectedIndexPathForButtonCollectionTag = IndexPath(row: 0, section: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRecentRecipesFromRealm()
        importantUIDownload()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel(text: "Get amazing recipe for cooking", font: UIFont.poppinsRegular20(), textColor: .black)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
    }
    
    @IBAction func trendingNowSeeAllButtonPressed(_ sender: UIButton) {
        let seeAllViewController = SeeAllViewController()
        navigationController?.pushViewController(seeAllViewController, animated: true)
    }
    
    // MARK: - CallNetworking Method

    private func callNetworking() {
        let trendingNowRequest = urlGenerator.request(endpoint: "food/search", queryItems: [URLQueryItem(name: "limitLicense", value: "true"), URLQueryItem(name: "limit", value: "10")])
        let popularCategoryRequest = urlGenerator.request(endpoint: "recipes/complexSearch", queryItems: [URLQueryItem(name: "type", value: "breakfast"), URLQueryItem(name: "addRecipeInformation", value: "true")])
        
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
    }
    
    private func loadRecentRecipesFromRealm(){
        let recipes = realm.objects(RecentRecipeModel.self)
        recentRecipes = Array(recipes).reversed()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case trendingNowCollectionView: return trendingNow.count
        case popularCategoryCollectionView: return popularCategoryTagArray.count
        case popularCategoryTagCollectionView: return popularCategoryArray.count
        case recentRecipeCollectionView: return recentRecipes.count
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
            let correctIndexPath = recentRecipes[indexPath.row]
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
        let currentCellID: Int
        let recipeImage: String
        let recipeName: String
        
        switch collectionView {
            case trendingNowCollectionView:
                currentCellID = trendingNow[indexPath.row].id
                recipeName = trendingNow[indexPath.row].name
                recipeImage = trendingNow[indexPath.row].image
            case popularCategoryCollectionView:
                currentCellID = popularCategoryTagArray[indexPath.row].id
                recipeName = popularCategoryTagArray[indexPath.row].title
                recipeImage = popularCategoryTagArray[indexPath.row].image
            case recentRecipeCollectionView:
                currentCellID = recentRecipes[indexPath.row].id
                recipeName = recentRecipes[indexPath.row].title
                recipeImage = recentRecipes[indexPath.row].imageURL
            default:
                return
            }
        
        // Saving data to the database
        let recentRecipeModel = RecentRecipeModel()
        recentRecipeModel.saveToRealm(id: currentCellID, imageURL: recipeImage, title: recipeName)
        
        // Push to RecipeDetailViewControler
        let detailRecipeModel: DetailRecipeModel = DetailRecipeModel(nameRecipe: recipeName, imageRecipe: recipeImage)
        let vc = RecipeDetailViewController(model: detailRecipeModel, id: currentCellID)
        navigationController?.pushViewController(vc, animated: true)
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

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let vc = SearchRecipeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
