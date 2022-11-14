var dicCountry = ["Polsca": "Varshava", "Germany": "Berlin", "Ukraine": "Kiev"]
var dicCity = ["Varshava": 12323, "Berlin": 443545, "Kiev": 243323]
var dicStudent = ["Vlad": false, "Victor": true, "Veronika": false]

let dicOneVar = (dicCountry["Polsca"], dicCity["Varshava"], dicStudent["Vlad"])
print(dicOneVar)

dicCountry.removeValue(forKey: "Germany")
dicCity["Berlin"] = nil
dicStudent.removeValue(forKey: "Victor")

var arrayStudentKeys = [String](dicStudent.keys)
var arrayStudentValues = dicStudent.values
print(arrayStudentKeys)
print(arrayStudentValues)

var arrayStudentSwap = arrayStudentKeys
arrayStudentSwap.swapAt(0, 1)
print(arrayStudentSwap)
