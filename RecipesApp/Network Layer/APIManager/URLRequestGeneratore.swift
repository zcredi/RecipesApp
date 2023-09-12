import Foundation

class URLRequestGeneratore {
    private let baseURL = "https://api.spoonacular.com/"
    private let apiKey = "3ddda5e4a8a64560a72989de5ff7a8a4"

    func request(endpoint: String, queryItems: [URLQueryItem] = []) -> URLRequest? {
        guard let baseURL = URL(string: baseURL) else { return nil }
        var components = URLComponents(url: baseURL.appendingPathComponent(endpoint), resolvingAgainstBaseURL: true)

        var defaultQueryItems = [URLQueryItem(name: "apiKey", value: apiKey)]
        defaultQueryItems.append(contentsOf: queryItems)

        components?.queryItems = defaultQueryItems

        guard let url = components?.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
}
