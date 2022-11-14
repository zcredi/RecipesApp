import CoreGraphics
import Foundation
import UIKit

func workings(_ name: String, prof: String = "Programmist", vac: Int = 25) {
    print("Меня зовут \(name), я работаю \(prof) и у меня есть \(String(vac)) дней отпуска")
}

//workings("Vlad")
//workings("Veron", prof: "Masterka")
//workings("Victor", vac: 42)

func sum(_ num1: String, _ num2: String) -> String {
    let result = num1 + num2
    return result
}

func sum(_ num1: Float, _ num2: Float) -> Float {
    let result = num1 + num2
    return result
}

func sum(_ num1: Int, _ num2: Int) -> Int {
    let result = num1 + num2
    return result
}

var sum1 = sum("10", "10")
var sum2 = sum(12.2, 12.2)
var sum3 = sum(15, 15)

//func doIam(name1: String = "Bob", closure: (String) -> ()) {
//    closure("")
//    print(name1)
//}
//
//doIam(closure: { values in
//    print(values)
//})
//
//doIam(name1: "Vlad") { name in
//    print(name)
//}
//
//doIam{print($0)}


