//MARK: Домашнее задание

//MARK: - Задача 1
//1. Создайте два массива. Каждый массив будет содержать в себе имена учеников класса
//Изначально известно, что в каждом классе по 5 учеников, но имена пока неизвестны


//2. В первый класс зачислили учеников с именами: Tom, Mike, Dan, Tim, John
//Во второй класс зачислили учеников с именами: Ann, Olivia, Emma, Ava, Sophia


//3. Пришла мама Tom'a и захотела узнать в какой класс определили ее сына
//Проверить в каком классе находится Tom


//4. Так как дети были приняты в случайном порядке, то необходимо записать их в алфавитном порядке.
//Проверьте, что изменения произошли


//5 В школе недостаток финансирования, поэтому было принято решение:
//отчислить из первого класса ученика, чье имя первое в алфавитном порядке,
//а из второго класса отчислить ученика, чье имя находится последним в алфавитном порядке.
//Вот такая несправедливая жизнь...


//6. Учеников стало меньше, поэтому было принято решение объединить два класса в один.
//Перевести всех учеников из второго класса в первый
//Удалить журнал с именами учеников второго класса. Проверить, что второй школьный класс(массив) пустой.
//Вывести в консоль имена учеников класса

var namesStudentOne = [String]()
var namesStudentTwo = [String]()

namesStudentOne += ["Tom", "Mike", "Dan", "Tim", "John"]
namesStudentTwo += ["Ann", "Olivia", "Emma", "Ava", "Sophia"]

if namesStudentOne.contains("Tom") {
    print("Tom учиться в 1 классе")
} else if namesStudentTwo.contains("Tom") {
    print("Tom учиться во 2 классе")
}

namesStudentOne.sort()
namesStudentTwo.sort()
print(namesStudentOne)
print(namesStudentTwo)

namesStudentOne.removeFirst()
namesStudentTwo.removeLast()

namesStudentOne += namesStudentTwo
namesStudentTwo.removeAll()
print(namesStudentTwo)
print("Выжившие: \(namesStudentOne)")



//MARK: - Задача 2
//1. В данной задаче будем использовать 3 валюты: Доллары, Евро, Фунты.
//Для каждой из них будем хранить значение в рублях.
//Создать словарь, явно указать тип хранимых данных

//2. Добавить в словарь 3 валюты со значениями:
//Доллар - 60
//Евро - 59
//Фунт - 70

//3. Вывести в консоль сообщение (без ковычек):
//"Курс доллара: _ р за 1 доллар
//Курс евро: _ р за 1 евро
//Курс фунта: _ р за 1 фунт"
//Обработать появившиеся ошибки/предупреждения


//4. Стало известно, что курс евро стал такой же как курс доллара
//Плииииз, не указывайте просто число
//Проверить, что курс изменился


//5. Было принято решение больше не использовать фунты
//Удалите фунты
//Выведите в консоль имена всех доступных валют

var currencies = [String : Int]()

currencies["dollar"] = 60
currencies["euro"] = 59
currencies["pound"] = 70

print("""
Курс доллара: \(currencies["dollar"] ?? 0) р за 1 доллар
Курс евро: \(currencies["euro"] ?? 0) р за 1 евро
Курс фунта: \(currencies["pound"] ?? 0) р за 1 фунт
""")

currencies["euro"] = currencies["dollar"]
currencies["euro"]

currencies.removeValue(forKey: "pound")

print("Доступные валюты \(currencies.keys)")

//MARK: - Дополнительная задача

//1. Создать 3 кортежа с изначально нулевыми параметрами.
// В каждом кортеже будем хранить 3 параметра человека:
// - Имя
// - Рост в метрах
// - Возраст, количество полных лет


//2. Заполнить кортежи:
//Для первого человека: Имя Mike, Рост 185см, Возраст 28
//Для второго человека: Имя Tom, Рост 174см, Возраст 30
//Для третьего человека: Имя Bob, Рост 162см, Возраст 31


//3. Вывести в консоль сообщение по каждому человеку в формате:
//Имя первого человека: _ , его рост: _ м, а возраст: _ г


//4. Создать пустой массив, который будет включать в себя вышесозданных людей


//5. Добавить в массив вышесозданных людей


//6. Вывести в консоль следующее сообщение:
//Сейчас в массиве _ человека. Имя первого: _, имя второго: _, имя третьего: _

var humanOneParameters = (name: "", heightMeters: 0.0, age: 0)
var humanTwoParameters = (name: "", heightMeters: 0.0, age: 0)
var humanThreeParameters = (name: "", heightMeters: 0.0, age: 0)

humanOneParameters = (name: "Mike", heightMeters: 185 / 100.0, age: 28)
humanTwoParameters = (name: "Tom", heightMeters: 174 / 100.0, age: 30)
humanThreeParameters = (name: "Bob", heightMeters: 162 / 100.0, age: 31)

print("""
Имя первого человека: \(humanOneParameters.name), его рост: \(humanOneParameters.heightMeters)м, а возраст: \(humanOneParameters.age)г.
Имя второго человека: \(humanTwoParameters.name), его рост: \(humanTwoParameters.heightMeters)м, а возраст: \(humanTwoParameters.age)г.
Имя третьего человека: \(humanThreeParameters.name), его рост: \(humanThreeParameters.heightMeters)м, а возраст: \(humanThreeParameters.age)г.
""")

var humanArray: [(String, Double, Int)] = []
humanArray += [(humanOneParameters), (humanTwoParameters), (humanThreeParameters)]

print("Сейчас в массиве \(humanArray.count) человека. Имя первого: \(humanArray[0].0), имя второго \(humanArray[1].0):  имя третьего: \(humanArray[2].0)")

