import UIKit

class Calculator {
    
    func add(num1: Int, num2: Int) -> Int {
        let sum = num1 + num2
        return sum
    }
    
    func subtract(num1: Int, num2: Int) -> Int {
        let sum = num1 - num2
        return sum
    }
    
    func multiply(num1: Int, num2: Int) -> Int {
        let sum = num1 * num2
        return sum
    }
    
    func divide(num1: Int, num2: Int) -> Double {
        let sum = num1 / num2
        return Double(sum)
    }
    
    func ostatok(num1: Int, num2: Int) -> Int {
        let sum = num1 % num2
        return sum
    }
}

class SuperCalculator: Calculator {
    
    func number(num1: Double, step: Int) -> Double {
        
        return pow(num1, Double(step))
    }
    
    func proc(num1: Double, percentageVal: Double) -> Double {
        let val = num1 * percentageVal
        return val / 100.0
    }
    override func add(num1: Int, num2: Int) -> Int {
        print("I am SuperCalculator")
        let sum = num1 + num2
        return sum
    }
    
    override func subtract(num1: Int, num2: Int) -> Int {
        print("I am SuperCalculator")
        let sum = num1 - num2
        return sum
    }
    
    override func multiply(num1: Int, num2: Int) -> Int {
        print("I am SuperCalculator")
        let sum = num1 * num2
        return sum
    }
    
    override func divide(num1: Int, num2: Int) -> Double {
        print("I am SuperCalculator")
        let sum = num1 / num2
        return Double(sum)
    }
    
    override func ostatok(num1: Int, num2: Int) -> Int {
        super.ostatok(num1: 10, num2: 4)
        print("I am SuperCalculator")
        let sum = num1 % num2
        return sum
    }
}

let cal = SuperCalculator()

cal.add(num1: 10, num2: 2)
cal.subtract(num1: 2, num2: 1)
cal.multiply(num1: 2, num2: 2)
cal.divide(num1: 10, num2: 5)
cal.ostatok(num1: 9, num2: 4)

print(SuperCalculator().multiply(num1: 1, num2: 2))
