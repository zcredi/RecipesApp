import SnapKit
import UIKit
import RealmSwift

class DiscoverViewController: UIViewController {
    private let realm = try! Realm()
    private let networkManager = NetworkManager()
    private let urlGenerator = URLGenerate()
    private var savedRecipe: [SavedRecipeModel] = []
    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Saved Recipe"
        createTable()
        view.addSubview(tableView)
        setupConstrains()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let recipes = realm.objects(SavedRecipeModel.self)
        savedRecipe = Array(recipes).reversed()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateTableView()
    }
}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let newCell = cell as? CustomViewTableCell else {
            return cell
        }
        newCell.selectionStyle = .none
        newCell.createCell(recipe: savedRecipe[indexPath.row])
        return newCell
    }
    
    func createTable() {
        view.addSubview(tableView)
        tableView.register(CustomViewTableCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 270
    }
    
    func setupConstrains() {
        tableView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentIndexPath = savedRecipe[indexPath.row]
        
        let detailModel = DetailRecipeModel(nameRecipe: currentIndexPath.title, imageRecipe: currentIndexPath.image)
        let vc = RecipeDetailViewController(model: detailModel, id: currentIndexPath.id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func animateTableView() {
        tableView.reloadData()
        if !savedRecipe.isEmpty{
            let cells = tableView.visibleCells
            let tableViewHeight = tableView.bounds.height
            var delay: Double = 0
            
            for cell in cells {
                cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
                
                UIView.animate(withDuration: 1.5,
                               delay: delay * 0.05,
                               usingSpringWithDamping: 0.8,
                               initialSpringVelocity: 0,
                               options: .curveEaseInOut,
                               animations: {
                    cell.transform = CGAffineTransform.identity
                },completion: nil)
                delay += 1
            }
        }
    }
}
