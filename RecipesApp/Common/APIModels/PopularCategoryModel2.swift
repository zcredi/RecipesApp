import Foundation

struct SearchResponse: Codable {
    var searchResults: [SearchResult]
}

struct SearchResult: Codable {
    var results: [Recipe]
}

struct Recipe: Codable {
    var id: Int
    var name: String
    var image: String
}
