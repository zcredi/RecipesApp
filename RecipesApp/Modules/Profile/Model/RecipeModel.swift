import Foundation

struct CreateRecipeModel: Codable {
    let cookTime: String
    let image: String
    let ingredients: [IngredientsItemModel]
    let title: String
}

struct IngredientsItemModel: Codable {
    let itemName: String
    let quantity: String
}


enum ProfileError: Error {
    case firestoreError(Error)
    case decodingError
    case unknownError
    case authenticationError
    
    var localizedDescription: String {
        switch self {
        case .firestoreError(let error):
            return "Firestore error: \(error.localizedDescription)"
        case .decodingError:
            return "Decoding error."
        case .unknownError:
            return "An unknown error occurred."
        case .authenticationError:
            return "User is not authenticated."
        }
    }
}
