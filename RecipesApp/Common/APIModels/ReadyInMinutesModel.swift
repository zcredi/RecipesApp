import Foundation

struct ReadyInMinutes: Codable {
    var sourceName: String
    var extendedIngredients: [ReadyInMinutesIngredient]
    var id: Int
    var title: String
    var readyInMinutes: Int
}

struct ReadyInMinutesIngredient: Codable {
    var id: Int
    var image: String
    var name: String
}
