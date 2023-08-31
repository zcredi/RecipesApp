import Foundation


class PopularCategoryManager {
    let url = "https://api.spoonacular.com/recipes/complexSearch?&type=drink&addRecipeInformation=true"
    let apiKey = "apiKey=3ddda5e4a8a64560a72989de5ff7a8a4"
    
    func getRecipeCategory(category: String, _ completionHandler: @escaping ([PopularCategory]) -> Void) {
        
    }
}
