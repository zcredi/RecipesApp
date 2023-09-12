import Foundation

class NetworkManager {
    enum NetworkManagerError: Error {
        case requestNotDefined
        case resultIsEmpty
        case apiKeyLimitReached
    }
    
    private let jsonDecoder = JSONDecoder()
    
    func request<T: Decodable>(generator: URLRequest?, _ completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let request = generator else {
            DispatchQueue.main.async {
                completionHandler(.failure(NetworkManagerError.requestNotDefined))
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            let result: Result<T, Error>
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 429 {
                result = .failure(NetworkManagerError.apiKeyLimitReached)
            } else if let error = error {
                result = .failure(error)
            } else if let data = data {
                do {
                    let decodedObject = try self.jsonDecoder.decode(T.self, from: data)
                    result = .success(decodedObject)
                
                } catch let decodingError as DecodingError {
                    print(decodingError.errorDescription) // Лучше использовать SwiftyBEAVER
                    result = .failure(decodingError)
                } catch {
                    result = .failure(error)
                }
            } else {
                result = .failure(NetworkManagerError.resultIsEmpty)
            }
            
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
        task.resume()
    }
}
