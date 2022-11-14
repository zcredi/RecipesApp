import CoreGraphics
import Foundation
import UIKit

class Phone {
    
    var number: Int
    var model: String
    var weight: Int
    
    init(n: Int, m: String, w: Int) {
        number = n
        model = m
        weight = w
    }
    
    func receiveCall(nameCallers: String, numberCallers: Int) {
        print("Звонит \(nameCallers). Номер телефона \(numberCallers)")
        
    }
    func getNumber() -> Int {
        print(number)
        return number
    }
    func sendMessage(number: Int) {
        print("Сообщение будет отправлено на номер \(number)")
    }
    
}

let myPhone = Phone(n: 12321321321, m: "iPhone", w: 230)

//print(myPhone.number, myPhone.model, myPhone.weight)

let friendPhone = Phone(n: 2132321, m: "LG", w: 150)

//print(friendPhone.number, friendPhone.model, friendPhone.weight)

//myPhone.receiveCall(nameCallers: "Bob")
//myPhone.getNumber()

var arrayPhone: [Phone] = [myPhone, friendPhone]

for phone in arrayPhone {
    phone.getNumber()
    phone.receiveCall(nameCallers: "Ivan", numberCallers: 123213213)
    phone.sendMessage(number: 1232131)
}
