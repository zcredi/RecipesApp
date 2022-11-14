import Darwin
let minValue = Int8.min
let maxValue = Int8.max
let minNumber = UInt8.min
let maxNumber = UInt8.max
let intMax = Int.max
let intMaxDouble = Double (Int.max)

print("Минимальное число Int8:", minValue)
print("Максимальное число Int8:", maxValue)
print("Минимальное число UInt8:", minNumber)
print("Максимальное число UInt8:", maxNumber)
print("Максимальное число Int:", intMax)
print("Максимальное число Int с плавущей точкой:", intMaxDouble)

let numberInt = 5
let numberDouble = 2.7
let numberFloat : Float = 3.4

let sumInt = Int(Double(numberInt) + numberDouble + Double(numberFloat))
let sumDouble = Double(numberInt) + numberDouble + Double(numberFloat)
let sumFloat = Float(numberInt) + Float(numberDouble) + numberFloat

if Double(sumInt) == sumDouble {
    print("Double")
} else if Double(sumInt) < sumDouble {
    print("Double =")
} else {
    print("Int")
}
