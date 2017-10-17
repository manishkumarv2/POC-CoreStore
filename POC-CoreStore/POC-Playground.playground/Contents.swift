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


