import Foundation

class CreateRecipeViewModel {
    var servesCount = ["01", "02", "03", "04", "05"]
    var cookTime = CookTime.allCases.map { $0.rawValue }
}

