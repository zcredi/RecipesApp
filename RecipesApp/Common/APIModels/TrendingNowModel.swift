import Foundation

struct SearchResponse: Decodable {
    let searchResults: [SearchResult]
}

struct SearchResult: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let id: Int
    let name: String
    let image: String
}
