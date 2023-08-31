import Foundation

struct PopularCategory: Codable {
    var results: [PopularCategoryInfo]
}

struct PopularCategoryInfo: Codable {
    var id: Int
    var title: String
    var readyInMinutes: Int
    var image: String
}
