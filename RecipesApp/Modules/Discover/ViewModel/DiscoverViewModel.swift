import Foundation
import RealmSwift

class DiscoverViewModel {
    private let realm = try! Realm()
    private let networkManager = NetworkManager()
    private let urlGenerator = URLRequestGeneratore()
    var savedRecipe: [SavedRecipeModel] = []
    
    func fetchSavedRecipe() {
        let recipes = realm.objects(SavedRecipeModel.self)
        savedRecipe = Array(recipes).reversed()
    }
    
    
}
