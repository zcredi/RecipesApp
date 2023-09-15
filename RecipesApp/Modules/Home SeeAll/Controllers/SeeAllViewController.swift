import UIKit
import RealmSwift

class SeeAllViewController: UIViewController {
    private lazy var seeAllViewModel = SeeAllViewModel()
    private lazy var seeAllTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        tableView.layer.cornerRadius = 30
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTrendingNow()
        setupNavigationBarWithBackButton()
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        navigationItem.title = "Trending now"
        view.backgroundColor = .systemBackground
        view.addSubview(seeAllTableView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            seeAllTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            seeAllTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            seeAllTableView.topAnchor.constraint(equalTo: view.topAnchor),
            seeAllTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        
        ])
        
    }
    private func fetchTrendingNow() {
        seeAllViewModel.fetchTrendingNow {
            self.seeAllTableView.reloadData()
        }
    }
}

extension SeeAllViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seeAllViewModel.trendingNow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(withModelRecipe: seeAllViewModel.trendingNow[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    
}


extension SeeAllViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentIndexPath = seeAllViewModel.trendingNow[indexPath.row]
        seeAllViewModel.saveRecipeToRealm(id: currentIndexPath.id, imageURL: currentIndexPath.image, title: currentIndexPath.name) 
        let vc = RecipeDetailViewController(recipe: currentIndexPath.name, image: currentIndexPath.image, id: currentIndexPath.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}
