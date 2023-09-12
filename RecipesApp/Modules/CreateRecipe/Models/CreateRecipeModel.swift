import RealmSwift

class RecipeModel: Object {
    @Persisted var recipeImage: Data?
    @Persisted var recipeName: String = "Unknown"
    @Persisted var serves: String = "Unknown"
    @Persisted var cookTime: String = "Unknown"
}
