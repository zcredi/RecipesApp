import Firebase
import GoogleSignIn
import GoogleSignInSwift

class AuthorizationViewModel {
    
    
    func checkAuthorization(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(Auth.auth().currentUser != nil)
    }
    
    func signInWithGoogle(vc: UIViewController, completion: @escaping () -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { [weak self] result, error in
            guard error == nil else {
                print("Error: \(error?.localizedDescription ?? "No error description")")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("Error: No user or idToken")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { [weak self] result, error in
                guard error == nil else {
                    print("Error: \(error?.localizedDescription)")
                    return
                }

                guard let user = result?.user else {
                    print("Error: No user")
                    return
                }

                completion()
            }
        }
    }
    func signInWithFirebase(email: String, password: String, completion: @escaping (Result<Void, FirebaseSignInError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            if let nsError = error as NSError? {
                let firebaseError = FirebaseSignInError.map(from: nsError)
                completion(.failure(firebaseError))
            } else {
                completion(.success(()))
            }
        }
    }
}
