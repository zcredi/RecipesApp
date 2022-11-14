let weekDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

for weekDay in weekDays {
//    print(weekDay)
}

for (index, weekDay) in weekDays.enumerated() {
   print("Порядковый номер: \(index), день недели: \(weekDay)")
    if index == 3 {
        break
    }
}

let ageFriends = [26, 20, 23, 24, 29, 19, 17, 21, 30, 28]

for ageFriend in ageFriends {
    print("Мне \(ageFriend) лет")
    if ageFriend < 18 {
        print("Я уже отпраздновал: \(ageFriend) лет")
    }
    if ageFriend > 18 {
        print("Взрослый")
    }
}

