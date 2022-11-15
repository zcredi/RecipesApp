import UIKit

// Task 1

var number = [10, 15, 20, 25, 30, -30, -25, -20, -15, -10]

// Task 2

for var num in number {
    if num < 0 {
        num = 0
    }
    print(num)
}

// Task 3

number.min()
number.max()

//print(number.min(), number.max())

// Task 4

let sum = number.reduce(0, +)
//print(sum)

// Task 5

var monthArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
var monthDictionary: [String: Any] = [:]

for (element, index) in monthArray.enumerated() {
    monthDictionary[String(index)] = element
}

//print(monthDictionary)

// Task 6

var dictionary = ["first": 1, "second": 2, "third": 3, "fourth": 4]

(dictionary["first"], dictionary["fourth"]) = (dictionary["fourth"], dictionary["first"])

// Task 7

var calendar = [Int: [String]]()

    for year in 1970...2022 {
        calendar[year] = monthArray
    }

//print(calendar)

// Task 8

let newMonth = "notamonth"

for key in calendar.keys {
    calendar[key]?.append(newMonth)
}

// Task 9

var dates = [Int]()

for date in 1...31 {
    dates.append(date)
}

