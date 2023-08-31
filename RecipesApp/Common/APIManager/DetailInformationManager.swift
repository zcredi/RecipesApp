import Foundation

class DetailInformationManager {
    let urlString = "https://api.spoonacular.com/recipes/"
    let apiKey = "apiKey=3ddda5e4a8a64560a72989de5ff7a8a4"
    
    func getInfo(id: Int, _ completionHandler: ([InformationIngradient]) -> Void) {
        guard let url = URL(string: urlString + "\(id)" + "/analyzedInstructions?" + apiKey) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error)
            }
            if let httpReponse = response as? HTTPURLResponse,
               httpReponse.statusCode == 200,
               let responseData = data {
                if let recipe = try? JSONDecoder().decode([InformationIngradient].self, from: responseData){
                    print(recipe[0].steps[0].step)
                }
                
            }
        }
    }
}
