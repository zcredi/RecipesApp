import Foundation
import RealmSwift

class SeeAllViewModel {
    private let networkManager = NetworkManager()
    private let urlGenerator = URLRequestGeneratore()
    private let realm = try! Realm()
    var trendingNow: [Recipe] = []
    let recentRecipe = RecentRecipeModel()
    
    func fetchTrendingNow(completion: @escaping () -> Void){
        let trendingNowRequest = urlGenerator.request(endpoint: "food/search", queryItems: [URLQueryItem(name: "limitLicense", value: "true"), URLQueryItem(name: "limit", value: "14")])
        
        networkManager.request(generator: trendingNowRequest) { (result: Result<SearchResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let searched):
                    self.trendingNow = searched.searchResults[0].results
                    completion()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }
}
