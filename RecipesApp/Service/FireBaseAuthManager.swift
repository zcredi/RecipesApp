import Foundation
import FirebaseAuth
import Firebase

protocol FireBaseAuthProtocol: AnyObject {
    func createUser(userName: String, eMail: String, pwd: String, completionBlock: @escaping(Result<UserAuthData,Error>) -> Void)
    func signIn(eMail: String, pwd: String, completionBlock: @escaping(Result<UserAuthData,Error>) -> Void)
    func signOut(completionBlock: @escaping(Result<Bool,Error>) -> Void)
}

class FireBaseAuthManager: FireBaseAuthProtocol {
    
    func signOut(completionBlock: @escaping (Result<Bool, Error>) -> Void) {
        let fireBaseAuth = Auth.auth()
        do {
            try fireBaseAuth.signOut()
            completionBlock(.success(true))
        } catch let error as NSError {
            print ("Error SignOut:%@", error)
            completionBlock(.failure(error))
        }
    }
    
    func createUser(userName: String, eMail: String, pwd: String, completionBlock: @escaping (Result<UserAuthData, Error>) -> Void) {
        Auth.auth().createUser(withEmail: eMail, password: pwd) {(authResult, error) in
            if let error = error {
                completionBlock(.failure(error))
                return
            } else {
                let user = UserAuthData(userName: authResult?.user.displayName ?? "Test",
                                        userEmail: authResult?.user.email ?? "Test@Test.ru")
                completionBlock(.success(user))
            }
            
            
        }
    }
    
    func signIn(eMail: String, pwd: String, completionBlock: @escaping (Result<UserAuthData, Error>) -> Void) {
        Auth.auth().signIn(withEmail: eMail, password: pwd) {(authResult, error) in
            if let error = error {
                completionBlock(.failure(error))
                return
            } else {
                let user = UserAuthData(userName: authResult?.user.displayName ?? "Test",
                                        userEmail: authResult?.user.email ?? "Test@Test.ru")
                completionBlock(.success(user))
            }
            
            
        }
    }
    
    
    
}
