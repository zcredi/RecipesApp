import CoreGraphics
import Foundation
import UIKit


//func initials(name: String, surname: String) -> String {
//    let fullName = name + " " + surname
//    return fullName
//}
//
////print(initials(name: "Vladislav", surname: "Radchikov"))
//
//func sqrt(num: Double) -> Double {
//    let koren = num.squareRoot()
//    return koren
//}
//
////num(num: 144)
//
//func number(number1: Double) -> Double {
//    let twoStep = pow(number1, 2)
//    return twoStep
//}
//
////number(number1: 3)
//
//func squareRoot(num1: Double, num2: Double) -> Double {
//    let sumSquare = (sqrt(num1) + num2.squareRoot())
////    print("Cумма квадратного корня первого числа из \(num1) и второго числа \(num2) во второй степени равна \(sumSquare)")
//    return sumSquare
//}
//
////squareRoot(num1: 144, num2: 144)
//
//var sqtr:Double = 1
//var qstr:Double = 1
//
//for i in 1...10 {
//    for i in 1...10 {
//        squareRoot(num1: sqtr, num2: qstr)
//        qstr += 1
//    }
//    sqtr += 1
//}

let weekDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

//func weekDay(weekDays: Array<String>) -> Array<String> {
//    let day = weekDays
//    return day
//}
//
//weekDay(weekDays: weekDays)

func weekDay(weekDays: Array<String>) -> Array<String> {
    for (index, weekDay) in weekDays.enumerated() {
        print("Порядковый номер: \(index), день недели: \(weekDay)")
        if index == 2 {
            break
        }
    }
    return weekDays
}

weekDay(weekDays: weekDays)

let ageFriends = [26, 20, 23, 24, 29, 19, 17, 21, 30, 28]

func friend(ageFriends: Array<Int>) -> Array<Int> {
    for ageFriend in ageFriends {
        print("Мне \(ageFriend) лет")
        if ageFriend < 18 {
            print("Я уже отпраздновал: \(ageFriend) лет")
        }
        if ageFriend > 18 {
            print("Взрослый")
        }
    }
    return ageFriends
}

friend(ageFriends: ageFriends)
