import Foundation

struct PopularCategory: Decodable {
    let results: [PopularCategoryInfo]
}

struct PopularCategoryInfo: Decodable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let image: String
}
