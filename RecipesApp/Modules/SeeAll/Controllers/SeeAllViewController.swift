import UIKit
import RealmSwift
class SeeAllViewController: UIViewController {
    
    
    private lazy var seeAllTableView = SeeAllTableView()
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarWithBackButton()
        seeAllTableView.recipeSelectionDelegate = self
        setupUI()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        seeAllTableView.layer.cornerRadius = 30
    }

    private func setupUI() {
        title = "Trending now"
        view.backgroundColor = .systemBackground
        view.addSubview(seeAllTableView)

    }
    
    private func setupConstraints() {
        seeAllTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            seeAllTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            seeAllTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            seeAllTableView.topAnchor.constraint(equalTo: view.topAnchor),
            seeAllTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        
        ])
        
    }
}

// I moved the logic here because we can't in the didSelectImem method in the view go to the next controller
// by: @fullzoom


extension SeeAllViewController: SeeAllTableViewDelegate{
    func didSelectRecipe(recipe: Recipe) {
        
        let recentRecipeModel = RecentRecipeModel()
        recentRecipeModel.saveToRealm(id: recipe.id, imageURL: recipe.image, title: recipe.name)
        
        let detailModel = DetailRecipeModel(nameRecipe: recipe.name, imageRecipe: recipe.image)
        let vc = RecipeDetailViewController(model: detailModel, id: recipe.id)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
