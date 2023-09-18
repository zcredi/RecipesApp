import Foundation
import Firebase
import FirebaseFirestore

class ProfileViewModel {
    private let db = Firestore.firestore()
    private let jsonDecoder = JSONDecoder()
    var recipes: [CreateRecipeModel] = []

    func fetchRecipes(completion: @escaping (Result<[CreateRecipeModel], ProfileError>) -> Void) {
            guard let userID = Auth.auth().currentUser?.uid else {
                completion(.failure(.authenticationError))
                return
            }

            db.collection("Recipes").document(userID).collection("userRecipes").getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(.firestoreError(error)))
                    return
                }
                
                guard let snapshot = snapshot else {
                    completion(.failure(.unknownError))
                    return
                }

                var loadedRecipes: [CreateRecipeModel] = []
                for document in snapshot.documents {
                    do {
                        let recipe = try self.decodeRecipe(documentData: document.data())
                        loadedRecipes.append(recipe)
                    } catch let error as ProfileError {
                        completion(.failure(error))
                        return
                    } catch {
                        completion(.failure(.unknownError))
                        return
                    }
                }
                self.recipes = loadedRecipes
                completion(.success(self.recipes))
            }
        }

    private func decodeRecipe(documentData: [String: Any]) throws -> CreateRecipeModel {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: documentData, options: []) else {
            throw ProfileError.decodingError
        }
        guard let recipe = try? jsonDecoder.decode(CreateRecipeModel.self, from: jsonData) else {
            throw ProfileError.decodingError
        }
        return recipe
    }
}
