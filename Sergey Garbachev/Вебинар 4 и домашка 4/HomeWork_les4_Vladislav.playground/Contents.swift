//MARK: - Домашнее задание

//ЗАДАЧА 1
// 1.1 Создать константу numberOfMonth и присвоить ей любое значение от 1 до 12.
// 1.2 Используя инструкцию if, определить в каком квартале года находится данный месяц, и вывести в консоль сообщение: "Ваш день рождения в _ квартале года"
// 1.3 Сделать тоже самое при помощи инструкции switch

let numberOfMonth = 10

if numberOfMonth < 3 {
    print("Ваш день рождения в 1 квартале года")
} else if numberOfMonth < 6 {
    print("Ваш день рождения в 2 квартале года")
} else if numberOfMonth < 9 {
    print("Ваш день рождения в 3 квартале года")
} else if numberOfMonth < 12 {
    print("Ваш день рождения в 4 квартале года")
}


switch numberOfMonth {
case 1...3:
    print("Ваш день рождения в 1 квартале года")
case 4...6:
    print("Ваш день рождения в 2 квартале года")
case 7...9:
    print("Ваш день рождения в 3 квартале года")
case 10...12:
    print("Ваш день рождения в 4 квартале года")
default:
    print("Ты программист, у тебя нет дней, у тебя нет кварталов")
}

//ЗАДАЧА 2
// Человек берет ипотеку
// Сумма ипотеки 1_450_000
// Ипотечная ставка 12% годовых (проценты пересчитываются каждый год от оставшейся от квартиры суммы)
// Ежемесячный платеж составляет - 20_000
// Вычислить за сколько лет он выплатит ипотеку
// Вычислить переплату и вывести в консоль сообщение "Переплата за _ лет составила _ . Это _(переплата в процентах) % от первоначальной цены"

var sumMortgage = 1_450_000
let percentYear = sumMortgage / 100 * 12
let monthlyPaymentMortgage = 20_000
var yearSlavery = 0
var overpayment = 0


repeat {
    sumMortgage += percentYear
    overpayment += percentYear
    sumMortgage -= monthlyPaymentMortgage * 12
    yearSlavery += 1
    
} while sumMortgage > 0

let percentOverpayment = overpayment * 100 / 1_450_000

print("Платим и плачем \(yearSlavery) г")
print("Переплата за \(yearSlavery) лет составила \(overpayment). Это \(percentOverpayment) % от первоначальной цены")

//1_000_000 - Изначальная сумма в январе     1 год
//120_000 - 12% от суммы
//240_000 - оплата в год
//880_000 - сумма на начало нового года
//
//880_000 - Изначальная сумма в январе       2 год
//105_600 - 12% от суммы
//240_000 - оплата в год
//745_600 - сумма на начало нового года

// 3 год начнется с 745600


//ЗАДАЧА 3
// 3.1 Создайте массив, который содержит числа от 1 до 100 по возрастанию
// 3.2 Создайте новый массив, который будет содержать только четные значения из первого массива
// 3.3 Создайте новый массив, который будет содержать числа от 10 до 20 в случайном порядке. Числа не должны повторяться

let ascendingArray = [Int](1...100)
var evenArray = [Int]()

for even in ascendingArray {
    if even % 2 == 0 {
        evenArray.append(even)
    }
}

evenArray

var randomArray = [Int]()

while randomArray.count < 10 {
    for _ in 10...20 {
        var random = Int.random(in: 10...20)
        randomArray.append(random)
        var myRandomSet = Set<Int>(randomArray)
        randomArray = Array(myRandomSet)
    }
}


print(randomArray)

//ЗАДАЧА 4
// Улитка ползет по столбу. Высота столба 10 метров. За 1 день улитка поднимается по столбу на 2 метра, а за ночь - сползает на 1 метр. Определить через сколько дней улитка заберется на столб.

var startPost = 0
var days = 0

repeat {
    startPost += 2
    startPost -= 1
    days += 1
} while startPost < 10

print("За \(days) дней улитка заползет на столб")
