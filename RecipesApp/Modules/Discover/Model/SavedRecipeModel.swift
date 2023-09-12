import Foundation
import RealmSwift

class SavedRecipeModel: Object {
    @Persisted var id: Int = 0
    @Persisted var title: String = ""
    @Persisted var image: String = ""

    func deleteObjectFromRealm(id: Int) {
        do {
            let realm = try Realm()
            let objectsToDelete = realm.objects(SavedRecipeModel.self).filter("id == \(id)")
            
            try realm.write {
                realm.delete(objectsToDelete)
            }
        } catch {
            print("Error deleting object: \(error)")
        }
    }

    func saveToRealm(id: Int, image: String, title: String) {
        self.id = id
        self.image = image
        self.title = title

        let realm = try! Realm()

        do {
            try realm.write {
                realm.add(self)
            }
        } catch {
            print("Error saving to Realm: (error)")
        }
    }
}

