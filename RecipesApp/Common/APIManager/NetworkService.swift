import Foundation
import UIKit

class NetworkManager {
    func request<T: Decodable>(generator: URLRequest?, _ completionHandler: @escaping (Swift.Result<T, Error>) -> Void) {
        guard let request = generator else { return }
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(decodedObject))
            } catch let decodingError {
                completionHandler(.failure(decodingError))
            }
        }
        task.resume()
    }
}
