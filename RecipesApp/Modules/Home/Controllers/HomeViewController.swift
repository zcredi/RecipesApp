import UIKit

final class HomeViewController: UIViewController {
    let viewModel = HomeViewModel()
    private var selectedIndexPathForButtonCollectionTag: IndexPath?
    var uiSetupCompleted = false
    
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
    
    lazy var popularCategoryLabel = UILabel(text: "Popular Category", font: UIFont.poppinsBold20(), textColor: .black, numberOfLines: 1)
    lazy var recentRecipeLabel = UILabel(text: "Recent Recipe", font: UIFont.poppinsBold20(), textColor: .black, numberOfLines: 1)
    lazy var trendingNowLabel = UILabel(text: "Trending now 🔥", font: UIFont.poppinsBold20(), textColor: .black, numberOfLines: 1)
    lazy var popularCreatorsLabel = UILabel(text: "Popular Creators", font: UIFont.poppinsBold20(), textColor: .black, numberOfLines: 1)
    
    lazy var trendingNowCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 320, itemHeight: 250, delegate: self, dataSource: self)
        collectionView.register(TrendingNowCollectionViewCell.self, forCellWithReuseIdentifier: TrendingNowCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var popularCategoryTagCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 90, itemHeight: 40, delegate: self, dataSource: self)
        collectionView.register(SwitchPopularCategoryCollectionViewCell.self, forCellWithReuseIdentifier: SwitchPopularCategoryCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var popularCategoryCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 170, itemHeight: 200, delegate: self, dataSource: self)
        collectionView.register(PopularCategoryCollectionViewCell.self, forCellWithReuseIdentifier: PopularCategoryCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var recentRecipeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 150, itemHeight: 250, delegate: self, dataSource: self)
        collectionView.register(RecentRecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecentRecipeCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var popularCreatorsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(itemWidth: 120, itemHeight: 150, delegate: self, dataSource: self)
        collectionView.register(PopularCreatorsCollectionViewCell.self, forCellWithReuseIdentifier: PopularCreatorsCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Get amazing recipe for cooking"
        view.backgroundColor = .systemBackground
        selectedIndexPathForButtonCollectionTag = IndexPath(row: 0, section: 0)
        callNetworking()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRecentRecipesFromRealm()
        importantUIDownload()
    }
    
    @IBAction func trendingNowSeeAllButtonPressed(_ sender: UIButton) {
        let seeAllViewController = SeeAllViewController()
        seeAllViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(seeAllViewController, animated: true)
        
    }
    
    // MARK: - CallNetworking Method

    private func callNetworking() {
        viewModel.fetchTrendingNow {
            DispatchQueue.main.async {
                self.trendingNowCollectionView.reloadData()
            }
        }
        viewModel.fetchPopularCategory(for: "breakfast") {
            DispatchQueue.main.async {
                self.popularCategoryCollectionView.reloadData()
            }
        }
    }
    
    private func loadRecentRecipesFromRealm() {
        viewModel.loadRecentRecipesFromRealm()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case trendingNowCollectionView: return viewModel.trendingNow.count
        case popularCategoryCollectionView: return viewModel.popularCategoryTagArray.count
        case popularCategoryTagCollectionView: return viewModel.popularCategoryArray.count
        case recentRecipeCollectionView: return viewModel.recentRecipes.count
        case popularCreatorsCollectionView: return viewModel.popularCreatorsArray.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case trendingNowCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingNowCollectionViewCell.identifier, for: indexPath) as! TrendingNowCollectionViewCell
            let correctIndexPath = viewModel.trendingNow[indexPath.row]
            cell.configureCell(with: correctIndexPath)
            return cell
        case popularCategoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCategoryCollectionViewCell.identifier, for: indexPath) as! PopularCategoryCollectionViewCell
            let correctIndexPath = viewModel.popularCategoryTagArray[indexPath.row]
            cell.configureCell(with: correctIndexPath)
            return cell
        case popularCategoryTagCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwitchPopularCategoryCollectionViewCell.identifier, for: indexPath) as! SwitchPopularCategoryCollectionViewCell
            cell.delegate = self
            let category = viewModel.popularCategoryArray[indexPath.row]
            cell.configureCell(with: category)
            
            if indexPath == selectedIndexPathForButtonCollectionTag {
                cell.toggleButtonState()
            } else {
                cell.resetButtonState()
            }
            
            return cell
        case recentRecipeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentRecipeCollectionViewCell.identifier, for: indexPath) as! RecentRecipeCollectionViewCell
            let correctIndexPath = viewModel.recentRecipes[indexPath.row]
            cell.configureCell(with: correctIndexPath)
            return cell
            
        case popularCreatorsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCreatorsCollectionViewCell.identifier, for: indexPath) as! PopularCreatorsCollectionViewCell
            let correctIndexPath = viewModel.popularCreatorsArray[indexPath.row]
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
            currentCellID = viewModel.trendingNow[indexPath.row].id
            recipeName = viewModel.trendingNow[indexPath.row].name
            recipeImage = viewModel.trendingNow[indexPath.row].image
        case popularCategoryCollectionView:
            currentCellID = viewModel.popularCategoryTagArray[indexPath.row].id
            recipeName = viewModel.popularCategoryTagArray[indexPath.row].title
            recipeImage = viewModel.popularCategoryTagArray[indexPath.row].image
        case recentRecipeCollectionView:
            currentCellID = viewModel.recentRecipes[indexPath.row].id
            recipeName = viewModel.recentRecipes[indexPath.row].title
            recipeImage = viewModel.recentRecipes[indexPath.row].imageURL
        default:
            return
        }
        
        // Saving data to the database
       
        viewModel.saveRecipeToRealm(id: currentCellID, imageURL: recipeImage, title: recipeName)

        
        // Push to RecipeDetailViewControler
        let detailRecipeModel = DetailRecipeModel(nameRecipe: recipeName, imageRecipe: recipeImage)
        let vc = RecipeDetailViewController(model: detailRecipeModel, id: currentCellID)
        vc.hidesBottomBarWhenPushed = true
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
            viewModel.fetchPopularCategory(for: viewModel.popularCategoryArray[currentSelectedIndexPath.row].lowercased()) {
                DispatchQueue.main.async {
                        self.popularCategoryCollectionView.reloadData()
                }
            }
        }
    }
}
