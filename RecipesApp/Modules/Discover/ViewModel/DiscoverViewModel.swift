import Foundation
import RealmSwift

class DiscoverViewModel {
    private let realm = try! Realm()
    var savedRecipe: [SavedRecipeModel] = []
    
    func fetchSavedRecipe() {
        let recipes = realm.objects(SavedRecipeModel.self)
        savedRecipe = Array(recipes).reversed()
    }
    
    
}
