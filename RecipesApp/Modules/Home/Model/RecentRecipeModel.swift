// This is my first time trying to work with databases in programming. In this file, I created a model that we will use to store an object in the database so that we can display a picture, its title and id in recent recipes
// by: @fullzoom

import Foundation
import RealmSwift

class RecentRecipeModel: Object {
    @Persisted var id: Int = 0
    @Persisted var imageURL: String = ""
    @Persisted var title: String = ""

    func saveToRealm(id: Int, imageURL: String, title: String) {
        self.id = id
        self.imageURL = imageURL
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
