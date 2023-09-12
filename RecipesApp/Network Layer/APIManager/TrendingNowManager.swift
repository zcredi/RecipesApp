//import Foundation
//
//class TrendingNowManager {
//    let url = "https://api.spoonacular.com/food/search?"
//    let apiKey = "apiKey=3ddda5e4a8a64560a72989de5ff7a8a4"
//    
//    func getAllRecipe(_ completionHandler: @escaping ([TrendingNow]) -> Void) {
//        guard let url = URL(string: url + apiKey) else { return }
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if error != nil {
//                print(error)
//            }
//            if let httpReponse = response as? HTTPURLResponse,
//               httpReponse.statusCode == 200,
//               let dataResponse = data {
//                if let recipe = try? JSONDecoder().decode([TrendingNow].self, from: dataResponse){
//                    print(recipe[0].searchResults[0].name)
//                }
//            }
//        }
//        task.resume()
//    }
//}
