import Foundation

enum RecipeError: Error {
    case imageConversionFailed
    case downloadImageToDataBase
    case getURLInfo
    case downloadURLFailed
    case savingRecipeFailed
    var localizedDescription: String {
        switch self {
        case .imageConversionFailed:
            return "Не удалось конвертировать изображение"
        case .downloadImageToDataBase:
            return "Ошибка при загрузке изображения в базу данных"
        case .getURLInfo:
            return "Не удалось получить URL изображения"
        case .downloadURLFailed:
            return "Не удалось загрузить URL изображения"
        case .savingRecipeFailed:
            return "Ошибка при сохранении рецепта"
        }
    }
}
