//: Playground - noun: a place where people can play

import UIKit


var str = "Hello, playground"


let boolString: String = "00"
let boolInt: Int = 00
let boolFloat: Float = 0.1
let boolDouble: Double = 0.1
let dateString: String = "2017-02-23 18:30:00 +0000"

do{
    print(try Bool.convert(fromValue: boolString)!)
    print(try Bool.convert(fromValue: boolInt)!)
    print(try Bool.convert(fromValue: boolFloat)!)
    print(try String.convert(fromValue: dateString)!)

    print(try Bool.convert(fromValue: boolDouble)!)
    
    
}catch(let error){
    print(error)
}

do{
    print(try Bool.convert(fromValue: dateString)!)
}catch(let error){
    print(error)
}

var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
let indexesToRemove = [3, 5, 8, 12]

numbers = numbers
    .enumerated()
    .filter { !indexesToRemove.contains($0.offset) }
    .map { $0.element }

print(numbers)

struct Student {
    let firstName: String
    let lastName: String
    let age: Int
}

let s1 = Student(firstName: "M", lastName: "K", age: 37)
let s2 = Student(firstName: "K", lastName: "P", age: 29)
let s3 = Student(firstName: "C", lastName: "P", age: 32)
let s4 = Student(firstName: "A", lastName: "L", age: 22)
let s5 = Student(firstName: "M5", lastName: "K5", age: 37)
let s6 = Student(firstName: "K6", lastName: "P6", age: 29)
let s7 = Student(firstName: "C7", lastName: "P7", age: 32)
let s8 = Student(firstName: "A8", lastName: "L8", age: 22)


//var students = [s1,s2,s3,s4,s5,s6,s7,s8]
//let studentsToRemove = [s3, s5, s8, s2]
//
//students = students
//    .enumerated()
//    .filter { !studentsToRemove.contains(where: $0) }
//    .map { $0.element }
//
//print(students)
