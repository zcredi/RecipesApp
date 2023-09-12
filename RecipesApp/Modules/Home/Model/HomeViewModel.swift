import Foundation
import RealmSwift

class HomeViewModel {
    private let networkManager = NetworkManager()
    private let urlGenerator = URLRequestGeneratore()
    private let realmService = RealmService()
    
    var trendingNow: [Recipe] = []
    var popularCategoryTagArray: [PopularCategoryInfo] = []
    var recentRecipes: [RecentRecipeModel] = []
    var popularCategoryArray = DishCategory.allCases.map { $0.rawValue }
    var popularCreatorsArray = PopularCreator.allCases.map { $0.rawValue }
    
    func fetchTrendingNow(completion: @escaping () -> Void) {
        let trendingNowRequest = urlGenerator.request(endpoint: "food/search", queryItems: [URLQueryItem(name: "limitLicense", value: "true"), URLQueryItem(name: "limit", value: "10")])
            
        networkManager.request(generator: trendingNowRequest) { [weak self] (result: Swift.Result<SearchResponse, Error>) in
            switch result {
            case .success(let searched):
                self?.trendingNow = searched.searchResults[0].results
                completion()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
        
    func fetchPopularCategory(for category: String, completion: @escaping () -> Void) {
        let popularCategoryRequest = urlGenerator.request(endpoint: "recipes/complexSearch", queryItems: [URLQueryItem(name: "type", value: category), URLQueryItem(name: "addRecipeInformation", value: "true")])
            
        networkManager.request(generator: popularCategoryRequest) { [weak self] (result: Swift.Result<PopularCategory, Error>) in
            switch result {
            case .success(let searched):
                self?.popularCategoryTagArray = searched.results
                completion()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
        
    func loadRecentRecipesFromRealm() {
        recentRecipes = realmService.loadRecentRecipesFromRealm()
    }
        
    func saveRecipeToRealm(id: Int, imageURL: String, title: String) {
        let recentRecipeModel = RecentRecipeModel()
        recentRecipeModel.id = id
        recentRecipeModel.imageURL = imageURL
        recentRecipeModel.title = title
        realmService.saveRecipeToRealm(recipe: recentRecipeModel)
    }
}
