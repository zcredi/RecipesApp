import Foundation

// MARK: - InformationIngradient
struct InformationIngradient: Codable {
    var steps: [Step]
}

// MARK: - Step
struct Step: Codable {
    var number: Int
    var step: String
    var ingredients: [Ingredient]
    var equipment: [Equipment]
    var length: Length?
}

// MARK: - Ingredient
struct Ingredient: Codable {
    var id: Int
    var name: String
    var localizedName: String
    var image: String
}

// MARK: - Equipment
struct Equipment: Codable {
    var id: Int?
    var image: String
    var name: String
    var localizedName: String?
}

// MARK: - Length
struct Length: Codable {
    var number: Int
    var unit: String
}
