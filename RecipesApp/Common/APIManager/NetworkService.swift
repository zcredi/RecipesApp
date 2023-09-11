import Foundation

class NetworkManager {
    private let jsonDecoder = JSONDecoder()
    enum NetworkManagerError: Error {
        case requestNotDefined
        case resultIsEmpty
    }
    func request<T: Decodable>(generator: URLRequest?, _ completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let request = generator else {
            DispatchQueue.main.async {
                completionHandler(.failure(NetworkManagerError.requestNotDefined))
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else { return }
            let result: Result<T, Error>
            if let error = error {
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
        
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print(jsonString)
//            }
            
            
            DispatchQueue.main.async {
                completionHandler(result)
            }
            
        }
        task.resume()
    }
}
