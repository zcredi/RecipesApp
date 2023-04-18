//MARK: - Домашнее задание

/* 3 балла
ЗАДАНИЕ 1
 
 1.1 Создайте перечисление, содержащее математические действия:
 - сложение
 - вычитание
 - умножение
 - деление

 1.2 Создайте функцию, которая будет выполнять выбранную математическую операцию с двумя числами и выводить в консоль сообщение в виде:
    "Результат сложения 3 и 2 равен 5" <- это пример для сложения
    "Результат _ _ и _ равен _" <- это пример для сложения
 1.3 Вызовете функцию 4 раза со "всеми" возможными математическими действиями
*/

enum Calculator: Int {
    case addition
    case subtraction
    case multiplication
    case division
}

func calculator(numberOne: Int, numberTwo: Int,_ calculator: Calculator) -> Int {
    var result = 0
    switch calculator {
    case .addition:
        result = numberOne + numberTwo
    print("Результат сложения \(numberOne) и \(numberTwo) равен \(result)")
    case .subtraction:
        result = numberOne - numberTwo
        print("Результат вычитания \(numberOne) и \(numberTwo) равен \(result)")
    case .multiplication:
        result = numberOne * numberTwo
        print("Результат умножения \(numberOne) и \(numberTwo) равен \(result)")
    case .division:
        result = numberOne / numberTwo
        print("Результат деления \(numberOne) и \(numberTwo) равен \(result)")
    }
    return result
}

calculator(numberOne: 1, numberTwo: 2, .subtraction)


/*: 6 баллов
 ## Задание 2
 2.1 Создайте перечисление `DistanceUnit` (Единица измерения расстояния) со следующими кейсами: `versta`, `kilometer`, `mile`.
 
 Внутри перечисления `DistanceUnit` создайте еще одно перечисление `NonISUCountry` в котором содержится перечень стран не принявших международную систему единиц (США, Либерия и Мьянма).
 
 Верста и километр должны иметь ассоциативный параметры следующего типа: `(title: String, denotation: String, countries: [String])`. Миля - `(title: String, denotation: String, countries: [NonISUCountry])`. Первый параметр - это название единицы измерения, второй параметр отвечает за обозначение единицы, а массив должен содержать перечень стран в которых используется эта единица (для километра не обязательно перечислять все страны).

 2.2 Создайте по экземпляру DistanceUnit для каждого кейса и функцию, которая должна принимать единицу измерения и выводить на консоль информацию о ней, например: "Километр. Краткое наименование: км. Страны: Россия, Евросоюз".
 */

enum DistanceUnit {
    case versta(title: String, denotation: String, countries: [String])
    case kilometer(title: String, denotation: String, countries: [String])
    case mile(title: String, denotation: String, countries: [NonISUCountry])
    
    enum NonISUCountry: String {
        case USA = "США"
        case Liberia = "Либерия"
        case Myanmar = "Мьянма"
    }
}

let russia = DistanceUnit.kilometer(title: "Киллометр", denotation: "km", countries: ["Russia"])
let european = DistanceUnit.versta(title: "Верста", denotation: "в", countries: ["German"])
let nonCountry = DistanceUnit.mile(title: "Миля", denotation: "м", countries: [.USA])

func countryFunc( _country: DistanceUnit) {
    print("\(). Краткое наименование: км. Страны: Россия, Евросоюз")
}
