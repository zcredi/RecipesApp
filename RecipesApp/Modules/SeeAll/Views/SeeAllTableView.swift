import UIKit

protocol SeeAllTableViewDelegate: NSObject {
    func didSelectRecipe(recipe: Recipe)
}

class SeeAllTableView: UITableView {
    private let networkManager = NetworkManager()
    private let urlGenerator = URLGenerate()
    private var trendingNow: [Recipe] = []
    private var trendingNowIngradientAndTime: [ReadyInMinutes]
    weak var recipeSelectionDelegate: SeeAllTableViewDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        self.trendingNowIngradientAndTime = []
        super.init(frame: frame, style: style)
        callNetworking()
        configureTable()
        
    }
    
    // https://api.spoonacular.com/food/search?apiKey=3ddda5e4a8a64560a72989de5ff7a8a4&limitLicense=true&limit=14
    
    func callNetworking(){
        let trendingNowRequest = urlGenerator.request(endpoint: "food/search", queryItems: [URLQueryItem(name: "limitLicense", value: "true"), URLQueryItem(name: "limit", value: "14")])
        
        networkManager.request(generator: trendingNowRequest) { (result: Swift.Result<SearchResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let searched):
                    self.trendingNow = searched.searchResults[0].results
                    self.reloadData()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
        
    }

     
    func configureTable() {
        backgroundColor = .white
        separatorStyle = .none
        register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        dataSource = self
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - TableView Delegate
extension SeeAllTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingNow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(withModelRecipe: trendingNow[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentIndexPath = trendingNow[indexPath.row]
        recipeSelectionDelegate?.didSelectRecipe(recipe: currentIndexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}
