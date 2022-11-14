import UIKit

// Свойства и методы

class Phone {
    
    var number: Int
    var model: String
    
    init(n: Int, m: String) {
        number = n
        model = m
    }
    
    func getNumber() -> Int {
        print(number)
        return number
    }
    
}

// Экземляры класса и операции над ними

var phone1 = Phone(n: 133123, m: "Iphone")

var phone2 = Phone(n: 1233113, m: "android")

phone1 = phone2

phone1.number = 88767
phone1.model = "14 pro"
phone2.number = 3233343
phone2.model = "13"


print(phone1.number, phone1.model)
print(phone2.number, phone2.model)

// Наследование классов



// Структуры и их отличие от классов

struct Animal {
    
    var name: String
    var age: Int
    
    func eat() {
        print("Я умею есть")
    }
    
}

var animal1 = Animal(name: "Fox", age: 10)

var animal2 = Animal(name: "Wolf", age: 15)

animal1 = animal2

animal1.name = "Rabbit"
animal1.age = 5

animal2.name = "ferwdfds"
animal2.age = 3

print(animal1)
print(animal2)

struct Animall: Animal {
    
}
