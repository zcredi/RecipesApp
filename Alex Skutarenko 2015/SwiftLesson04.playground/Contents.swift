let myWallet:String? = "100"
var myAge:String? = "26"
let myName:String? = "Vladislav"
var myPhone:String? = "iPhone 13"
let myBook:String? = "Barbara Oakli"

var sum = 0

if let myWallet = myWallet, let wallet = Int(myWallet) {
    print(wallet)
    sum += wallet
}

if myAge != nil, let age = Int(myAge!) {
    print(age)
    sum += age
}

if let myName = myName, let name = Int(myName) {
    print(name)
    sum += name
}

if let myPhone = myPhone, let phone = Int(myPhone) {
    print(phone)
    sum += phone
}

if myBook != nil, let book = Int(myBook!) {
    print(book)
    sum += book
}

print(sum)

let serverResponse : (Int?, String?, String?) = (300, "Messenge", "Are Messenge")

var (status, check, check1) = serverResponse

var status1 = 0
var checkMes = ""
var checkAre = ""

if status != nil {
    Int(status!)
    status1 += status!
}

if check != nil {
    String(check!)
    checkMes += check!
}

if check1 != nil {
    String(check1!)
    checkAre += check1!
}

if 200...300 ~= status1 {
    print(checkMes)
} else {
    print(checkAre )
}

let serverResponse1 : (Int?, String?, String?) = (nil, "Messenge", "Are Messenge")

var (status12, check12, check13) = serverResponse1

var status123 = 0
var checkMes1 = ""
var checkAre1 = ""

if status12 == nil {
    print(status12)
}

if check12 != nil {
    String(check!)
    checkMes1 += check12!
}

if check1 != nil {
    String(check1!)
    checkAre += check1!
}

