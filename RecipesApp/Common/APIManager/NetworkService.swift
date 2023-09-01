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
            
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print(jsonString)
//            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(decodedObject))
            } catch let decodingError as DecodingError {
                switch decodingError {
                case .typeMismatch(let type, let context):
                    print("Type mismatch for type \(type) with context: \(context)")
                case .valueNotFound(let type, let context):
                    print("Value not found for type \(type) with context: \(context)")
                case .keyNotFound(let key, let context):
                    print("Key not found: \(key) with context: \(context)")
                case .dataCorrupted(let context):
                    print("Data corrupted with context: \(context)")
                @unknown default:
                    print("Unknown decoding error")
                }
                completionHandler(.failure(decodingError))
            } catch {
                print(error.localizedDescription)
                completionHandler(.failure(error))
            }

        }
        task.resume()
    }
}
