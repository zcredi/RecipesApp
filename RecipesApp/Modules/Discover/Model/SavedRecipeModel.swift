import Foundation
import RealmSwift

class SavedRecipeModel: Object {
    @Persisted var id: Int = 0
    @Persisted var title: String = ""
    @Persisted var image: String = ""
    
    
    func deleteObjectFromRealm(id: Int) {
        do {
            let realm = try Realm()
            if let objectToDelete = realm.objects(SavedRecipeModel.self).filter("id == \(id)").first {
                try realm.write {
                    realm.delete(objectToDelete)
                }
            }
        } catch {
            print("Error deleting object: \(error)")
        }
    }

    
    func saveToRealm(id: Int, image: String, title: String) {
        let savedRecipe = SavedRecipeModel()
        savedRecipe.id = id
        savedRecipe.image = image
        savedRecipe.title = title

        do {
            let realm = try Realm()
            try realm.write {
                realm.add(savedRecipe)
            }
        } catch {
            print("Error saving to Realm: \(error)")
        }
    }
}
