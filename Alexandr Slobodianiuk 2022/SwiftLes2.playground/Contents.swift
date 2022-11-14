var student = ["Vlad", "Veronika", "Victor", "Stas", "Andrey"]
let newStudent1 = "Vadim"
let newStudent2 = "Diana"

student.append(newStudent1)
student.insert(newStudent2, at: 0)

student.remove(at: 0)
student.remove(at: 4)

let studentArray = ["Rodion", "Valera"]

var studentAll = student + studentArray

print(studentAll.first)
print(studentAll.last)
print(studentAll[1])
print(studentAll[2])

print("В массиве содержится \(studentAll.count) элементов")
print("Является ли массив пустым: \(studentAll.isEmpty)")

let studentSuperAll = studentAll

studentAll.removeAll()

print(studentAll)
