import Foundation



func reverseSeq(n: Int) -> [Int] {
    var result = [Int]()
        for i in stride(from: n, to: 0, by: -1) {
            result.append(i)
        }
        return result
}

reverseSeq(n: 2)




//MARK: - Домашнее задание
//ЗАДАНИЕ 1: - 3балла
// 1.1 Создайте стуктуру User со следующими свойствами:
// - name: String
// - age: Int
// - money: Int
// - status: String
//1.2 - Свойство status должно возвращать сообщение с именем пользователя и количеством денег на его счету
//1.3 - Реализуйте метод plus, который увеличивает счет пользователя на 100 единиц
//1.4 - Создайте экземпляр структуры и инициализируйте ее свойства
//1.5 - Выведете в консоль свойство status
//1.6 - Вызовите метод plus
//1.7 - Выведете в консоль свойство status

struct User {
    let name: String
    let age: Int
    var money: Int
    var status: String {
        "Привет, меня зовут \(name) и у меня столько денег \(money)"
    }
    
    mutating func plus() {
        money += 100
    }
}

var user = User(name: "Vlad", age: 27, money: 100)
print(user.status)
user.plus()
print(user)


//ЗАДАНИЕ 2: - 3балла
//2.1 - Создайте класс Ball со следующими свойствами:
// - type: String
// - radius: Double
// - color: String
//2.2 - Создайте инициализатор, в котором значения для свойств type и color заданы по умолчанию, а свойство radius должно быть обязательным для инициализации
//2.3 -  Создайте свойство ballVolume, которое будет возвращать объем мяча. НО! вычисление объема необходимо реализовать в методе setBallVolume (число пи - либо 3.14, либо Double.pi)
// P.S. Для вычислений необходимо загуглить как возводить число в степерь в Swift
//2.4 - Создайте экземпляр класса, проинициализировав только радиус
//2.5 - Выведите в консоль сообщение "Объем мяча равен _", используя свойство ballVolume

class Ball {
    let type: String
    let radius: Double
    let color: String
    var ballVolume: Double {
        get {
            setBallVolume()
        }
    }
    
    init(type: String = "soccer", radius: Double, color: String = "red") {
        self.type = type
        self.radius = radius
        self.color = color
    }
    
    func setBallVolume() -> Double {
        return 4/3 * Double.pi * radius * radius * radius
    }
}

let ball = Ball(radius: 10)
ball.setBallVolume()
print("Объем мяча равен \(ball.ballVolume)")


//ЗАДАЧА 3: //MARK 6
//3.1 Создайте класс Student со следующими свойствами:
// - name: String
// - mark: Int
//3.2 - Создайте массив names вне класса, содержащий 5 имен (каждый элемент типа String)
//3.3 - Создайте пустой массив students, каждый элемент которого будет Student
//3.4 - Заполните массив students таким образом, чтобы он содержал 5 элементов, имена инициализируются случайными именами из массива names, а оценки создаются случайным образом в диапазоне от 1 до 5
//3.5 Проверте, что массив student содержит 5 элементов
//3.6 Используя цикл, выведите в консоль сообщение по каждому студенту в формате: "Оценка имяСтудента: оценкаСтудента"
//3.7 Используя цикл, выведите в консоль имена тех студентов, чья оценка 4 или 5
//3.8 Используя .filter для массива, сохраните в константу студентов, чью оценки 4 и 5
//3.9 Используя созданную выше константу и .forEach, выведете в консоль "Оценка имяСтудента: оценкаСтудента"

class Student {
    let name: String
    let mark: Int
    
    init(name: String, mark: Int) {
        self.name = name
        self.mark = mark
    }
}

let names = ["Vlad", "Ann", "Serg", "Bob", "Mark"]
var students = [Student]()

for _ in 0..<5 {
    let name = names.randomElement()
    let mark = Int.random(in: 1...5)
    students.append(Student(name: name ?? "Проверь есть ли значение", mark: mark))
}

students

for student in students {
    print("Оценка \(student.name): \(student.mark)")
}

for student in students {
    if student.mark >= 4 {
        print("\(student.name)")
    }
}

let studentExcellent = students.filter {$0.mark >= 4}

studentExcellent.forEach({ (student) in
    print("Оценка \(student.name): \(student.mark)")
})
