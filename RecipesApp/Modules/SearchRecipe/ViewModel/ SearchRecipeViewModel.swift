import Foundation

class SearchRecipeViewModel {
    private let networkManager = NetworkManager()
    private let urlGenerator = URLRequestGeneratore()
    var searchedRecipe: [InformationSearchRecipe] = []
    private var searchWorkItem: DispatchWorkItem?
    
    func fetchSearchRecipes(text: String, completion: @escaping () -> Void) {
        searchWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            let request = self.urlGenerator.request(endpoint: "recipes/complexSearch", queryItems: [URLQueryItem(name: "query", value: text), URLQueryItem(name: "addRecipeInformation", value: "true")])
            self.networkManager.request(generator: request) {[weak self] (result: Swift.Result<SearchRecipe, Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let searched):
                        self?.searchedRecipe = searched.results
                        completion()
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
            }
        }
        
        searchWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: workItem)
    }
}
