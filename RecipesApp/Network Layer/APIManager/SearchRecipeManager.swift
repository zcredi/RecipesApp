import Foundation

class SearchRecipeManager {
    let urlString = "https://api.spoonacular.com/recipes/complexSearch?"
    let apiKey = "apiKey=3ddda5e4a8a64560a72989de5ff7a8a4"
    
    func getRecipe(item: String, _ completionHandler: @escaping ([SearchRecipe]) -> Void) {
        guard let url = URL(string: urlString + apiKey + "&query=" + item) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error)
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200,
               let responseData = data{
                if let recipes = try? JSONDecoder().decode([SearchRecipe].self, from: responseData){
                    print(recipes[0].results[0].title)
                }
            }
        }
        task.resume()
    }
}
