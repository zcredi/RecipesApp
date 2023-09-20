import Foundation
import FirebaseAuth
enum FirebaseAuthError: String, Error {
    case emailAlreadyInUse = "The email address is already in use by another account."
    case invalidEmail = "The email address is badly formatted."
    case weakPassword = "The password must be 6 characters long or more."
    init?(from error: Error) {
        if let firebaseError = FirebaseAuthError(rawValue: error.localizedDescription) {
            self = firebaseError
        } else {
            return nil
        }
    }
}

enum FirebaseSignInError: Error {
    case userNotFound
    case wrongPassword
    case tooManyRequests
    case unknown

    var localizedDescription: String {
        switch self {
        case .userNotFound:
            return "User not found. Please register."
        case .wrongPassword:
            return "Incorrect password. Please try again."
        case .tooManyRequests:
            return "Too many requests. Try again later."
        case .unknown:
            return "Unknown error occurred."
        }
    }
    
    static func map(from error: NSError) -> FirebaseSignInError {
        switch error.code {
        case AuthErrorCode.userNotFound.rawValue:
            return .userNotFound
        case AuthErrorCode.wrongPassword.rawValue:
            return .wrongPassword
        case AuthErrorCode.tooManyRequests.rawValue:
            return .tooManyRequests
        default:
            return .unknown
        }
    }
}
