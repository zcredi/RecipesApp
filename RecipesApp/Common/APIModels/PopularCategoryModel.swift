import Foundation

struct PopularCategory: Decodable {
    var results: [PopularCategoryInfo]
}

struct PopularCategoryInfo: Decodable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let image: String
}
