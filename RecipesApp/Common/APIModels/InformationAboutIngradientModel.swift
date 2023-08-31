import Foundation

struct InformationIngradient: Codable {
    var steps: [Steps]
}

struct Steps: Codable {
    var number: Int
    var step: String
    
}

struct Ingradients: Codable {
    var name: String
}
