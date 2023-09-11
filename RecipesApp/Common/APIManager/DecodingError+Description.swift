import Foundation

extension DecodingError {
    var errorDescription: String {
        switch self {
            case .typeMismatch(let type, let context):
                return "Type mismatch for type \(type) with context: \(context)"
            case .valueNotFound(let type, let context):
                return "Value not found for type \(type) with context: \(context)"
            case .keyNotFound(let key, let context):
                return "Key not found: \(key) with context: \(context)"
            case .dataCorrupted(let context):
                return "Data corrupted with context: \(context)"
            @unknown default:
                return "Unknown decoding error"
        }
    }
}
