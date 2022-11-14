import UIKit

var passingScore = 20
var myScore = 111


//switch myScore {
//case 0...19: print("К сожалению, ваш балл ниже проходного")
//case 20...100: print("Поздравляем, вы поступили!")
//default: print("Поздравляем, вы поступили! Шутка, я не знаю :(")
//}

func univer() {
    guard passingScore > myScore else {
        print("Поздравляем, вы поступили!")
        return
    }
    
    print("К сожалению, ваш балл ниже проходного")
    
}

let message = myScore > passingScore ? "Поздравляем, вы поступили!" : "К сожалению, ваш балл ниже проходного"

var day = 2
let friday = 5

switch day {
case 1: print("Monday")
case 2 where friday != 2: print ("Tuesday")
fallthrough
case 3: print("Wednesday")
case 4: print("Thursday")
case 5: print("Friday")
case 6: print("Saturday")
case 7: print("Sunday")
default: print("Вы за пределами сознания.")
}
