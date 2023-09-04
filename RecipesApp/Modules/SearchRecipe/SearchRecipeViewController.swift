import UIKit

class SearchRecipeViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    private let urlGenerator = URLGenerate()
    private var searchedRecipe: [InformationSearchRecipe] = []
    private var searchWorkItem: DispatchWorkItem?
    private lazy var searchRecipesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchRecipeTableViewCell.self, forCellReuseIdentifier: SearchRecipeTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 250
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var searchRecipe: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "Search Recipes"
        sc.searchBar.delegate = self
        return sc
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchRecipe
        navigationItem.title = "Search Recipe"
    }
    
    private func setupUI() {
        view.addSubview(searchRecipesTableView)

        NSLayoutConstraint.activate([
            searchRecipesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            searchRecipesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchRecipesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchRecipesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SearchRecipeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchRecipeTableViewCell.identifier, for: indexPath) as! SearchRecipeTableViewCell
        cell.selectionStyle = .none
        cell.configure(image: searchedRecipe[indexPath.row].image, title: searchedRecipe[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentIndexPath = searchedRecipe[indexPath.row]
        let detailRecipeModel: DetailRecipeModel = DetailRecipeModel(nameRecipe: currentIndexPath.title, imageRecipe: currentIndexPath.image)
        let vc = RecipeDetailViewController(model: detailRecipeModel, id: currentIndexPath.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchRecipeViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            if let text = searchBar.text, !text.isEmpty {
                let request = self.urlGenerator.request(endpoint: "recipes/complexSearch", queryItems: [URLQueryItem(name: "query", value: text), URLQueryItem(name: "addRecipeInformation", value: "true")])
                self.networkManager.request(generator: request) { (result: Swift.Result<SearchRecipe, Error>) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let searched):
                            self.searchedRecipe = searched.results
                            self.searchRecipesTableView.reloadData()
                        case .failure(let failure):
                            print(failure.localizedDescription)
                        }
                    }
                }
            }
        }
        searchWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: workItem)
    }
}
