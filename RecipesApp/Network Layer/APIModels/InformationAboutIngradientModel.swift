import Foundation


struct InformationIngradient: Decodable {
    let steps: [Step]
}


struct Step: Decodable {
    let number: Int
    let step: String
    let ingredients: [Ingredient]
    let equipment: [Equipment]
    let length: Length?
}


struct Ingredient: Decodable, Hashable {
    let id: Int
    let name: String
    let localizedName: String
    let image: String
}


struct Equipment: Decodable {
    let id: Int?
    let image: String
    let name: String
    let localizedName: String?
}


struct Length: Decodable {
    let number: Int
    let unit: String
}
