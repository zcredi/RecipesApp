import Foundation
import RealmSwift

class RecentRecipeModel: Object {
    @Persisted var id: Int = 0
    @Persisted var imageURL: String = ""
    @Persisted var title: String = ""
}

class RealmService {
    private let realm = try! Realm()

    func saveRecipeToRealm(recipe: RecentRecipeModel) {
        do {
            try realm.write {
                realm.add(recipe)
            }
        } catch {
            print("Error saving to Realm: \(error)")
        }
    }

    func loadRecentRecipesFromRealm() -> [RecentRecipeModel] {
        let recipes = realm.objects(RecentRecipeModel.self)
        return Array(recipes).reversed()
    }
}
