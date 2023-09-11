import Foundation

// MARK: - InformationIngradient
struct InformationIngradient: Decodable {
    var steps: [Step]
}

// MARK: - Step
struct Step: Decodable {
    let number: Int
    let step: String
    let ingredients: [Ingredient]
    let equipment: [Equipment]
    let length: Length?
}

// MARK: - Ingredient
struct Ingredient: Decodable, Hashable {
    let id: Int
    let name: String
    let localizedName: String
    let image: String
}

// MARK: - Equipment
struct Equipment: Decodable {
    let id: Int?
    let image: String
    let name: String
    let localizedName: String?
}

// MARK: - Length
struct Length: Decodable {
    let number: Int
    let unit: String
}
