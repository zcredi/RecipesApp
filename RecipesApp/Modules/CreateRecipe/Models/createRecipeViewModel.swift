import Firebase
import FirebaseFirestore
import FirebaseStorage
import Foundation

class CreateRecipeViewModel {
    var servesCount = ["01", "02", "03", "04", "05"]
    var cookTime = CookTime.allCases.map { $0.rawValue }
    var onRecipeSaved: ((Bool, RecipeError?) -> Void)?
    
    func saveRecipe(image: UIImage, title: String, cookTime: String, ingredients: [IngredientsItemModel]) {
        // Убедимся, что у нас есть userID
        guard let userID = Auth.auth().currentUser?.uid else {
            onRecipeSaved?(false, RecipeError.downloadImageToDataBase)
            return
        }
        // 1. Convert Image to Data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            self.onRecipeSaved?(false, RecipeError.imageConversionFailed)
            return
        }
        
        // 2. Upload Image to Firebase Storage
        let storageRef = Storage.storage().reference().child("recipes/\(userID)/\(UUID().uuidString).jpg")
        storageRef.putData(imageData, metadata: nil) { [weak self] _, error in
            if let error = error {
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
                self?.onRecipeSaved?(false, RecipeError.downloadImageToDataBase)
                return
            }
            
            // 3. Get the image URL
            storageRef.downloadURL { [weak self] result in
                switch result {
                case .success(let urlImage):
                    
                    // 4. Save recipe to Firebase Firestore
                    let recipeData: [String: Any] = [
                        "image": urlImage.absoluteString,
                        "title": title,
                        "cookTime": cookTime,
                        "ingredients": ingredients.map { [
                            "itemName": $0.itemName,
                            "quantity": $0.quantity
                        ] }
                    ]
                    
                    let db = Firestore.firestore()
                    
                    // Указываем путь к документу с userID в качестве идентификатора в коллекции "Recipes", а затем вложенной коллекции "userRecipes"
                    let userRecipeRef = db.collection("Recipes").document(userID).collection("userRecipes").document()
                    
                    userRecipeRef.setData(recipeData) { error in
                        if let error = error {
                            print("Ошибка при добавлении рецепта: \(error.localizedDescription)")
                            self?.onRecipeSaved?(false, RecipeError.savingRecipeFailed)
                        } else {
                            print("Рецепт успешно добавлен!")
                            self?.onRecipeSaved?(true, nil)
                        }
                    }
                case .failure(let error):
                    print("Ошибка при получении URL изображения: \(error.localizedDescription)")
                    self?.onRecipeSaved?(false, RecipeError.getURLInfo)
                }
            }
        }
    }
}
