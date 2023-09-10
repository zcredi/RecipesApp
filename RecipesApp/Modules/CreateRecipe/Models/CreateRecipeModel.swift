//
//  SaveRecipeModel.swift
//  RecipesApp
//
//  Created by fullzoom on 09.09.2023.
//

import Foundation
import RealmSwift

class RecipeModel: Object {
    @Persisted var recipeImage: Data?
    @Persisted var recipeName: String = "Unknown"
    @Persisted var serves: String = "Unknown"
    @Persisted var cookTime: String = "Unknown"
}
