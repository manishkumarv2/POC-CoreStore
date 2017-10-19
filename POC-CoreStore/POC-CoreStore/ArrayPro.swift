//
//  ArrayPro.swift
//  POC-CoreStore
//
//  Created by Manish Kumar on 10/18/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation

extension Array {

    mutating func remove<T>(at indexes: [T]) -> Void {
        if let indexes = indexes as? [IndexPath] {
            for index in indexes {
                remove(at: index.row)
            }
        }else if let intValues = indexes as? [Int] {
            for index in intValues.sorted(by: >) {
                remove(at: index)
            }
        }
        else if let objectValues = indexes as? [Employee] {
            let array = self as! [Employee]
            let arrayResult = array.filter { element in
                return !objectValues.contains(element)
            }
            print(arrayResult)
        }
    }
    
//    mutating func remove(at indexes: [Int]) {
//        for index in indexes.sorted(by: >) {
//            remove(at: index)
//        }
//    }
//    
//    mutating func remove(at employees: [Employee]) {
//        for employee in employees {
////            remove(at: index.row)
////            self.contains(where: employee)
////            remove(at: self.indexOf(employee))
//            let setArray = Set<Employee>(self)
//            self = setArray.subtracting(Set(employees))
//        }
//    }
}
