import Foundation
import RealmSwift

class RecipeDetailViewModel {
    private let realm = try! Realm()
    public var id: Int = 0
    public var recipeName: String = ""
    public var recipeImage: String = ""
    private let networkManager = NetworkManager()
    private let urlGenerator = URLRequestGeneratore()
    let savedRecipe = SavedRecipeModel()
    
    var instruction: [Step] = []
    var ingredients: [Ingredient] = []
    var allIngredients: [Ingredient] = []
    var selectedIngredients: Set<Int> = []
    
    func checkObjectInRealm(successCompletion: @escaping () -> Void, failureCompletion: @escaping () -> Void) {
        let objects = realm.objects(SavedRecipeModel.self).filter("id == \(id)")
        objects.isEmpty ? failureCompletion() : successCompletion()
    }

    func saveToRealm(id: Int, image: String, title: String) {
        savedRecipe.saveToRealm(id: id, image: image, title: title)
    }
    
    func deleteObjectFromRealm(id: Int) {
        savedRecipe.deleteObjectFromRealm(id: id)
    }
    
    func fetchRecipe(successCompletion: @escaping () -> Void, failureCompletion: @escaping () -> Void) {
        
        let instructionRequest = urlGenerator.request(endpoint: "recipes/" + "\(id)/analyzedInstructions", queryItems: [URLQueryItem(name: "stepBreakdown", value: "true")])
        networkManager.request(generator: instructionRequest) { [weak self] (result: Result<[InformationIngradient], Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let searched):
                if !searched.isEmpty{
                    let instruction = searched[0].steps
                    let ingredients = instruction[0].ingredients
                    self.instruction = instruction
                    self.ingredients = ingredients
                    
                    for info in searched {
                        for step in info.steps {
                            self.allIngredients.append(contentsOf: step.ingredients)
                        }
                    }
                    
                    self.allIngredients = self.allIngredients.reduce([]) { acc, ingredient -> [Ingredient] in
                        if acc.contains(where: { $0.id == ingredient.id }) {
                            return acc
                        } else {
                            return acc + [ingredient]
                        }
                    }
                }
                successCompletion()
            case .failure:
                failureCompletion()
            }
        }
    }
}
