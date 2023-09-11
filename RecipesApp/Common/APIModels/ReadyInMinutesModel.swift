import Foundation

struct ReadyInMinutes: Decodable {
    let sourceName: String
    let extendedIngredients: [ReadyInMinutesIngredient]
    let id: Int
    let title: String
    let readyInMinutes: Int
}

struct ReadyInMinutesIngredient: Decodable {
    let id: Int
    let image: String
    let name: String
}
