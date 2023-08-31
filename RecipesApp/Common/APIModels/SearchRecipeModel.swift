import Foundation

struct SearchRecipe: Codable {
    var results: [InformationSearchRecipe]
}

struct InformationSearchRecipe: Codable {
    var id: Int
    var title: String
    var image: String
}


