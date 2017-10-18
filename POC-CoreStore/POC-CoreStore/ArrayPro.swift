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
//        var isDeleted = false
        if let indexes = indexes as? [IndexPath] {
            for index in indexes {
                remove(at: index.row)
//                isDeleted = true
            }
        }else if let intValues = indexes as? [Int] {
            for index in intValues.sorted(by: >) {
                remove(at: index)
//                isDeleted = true
            }
        } else if let objectValues = indexes as? [Employee] {
            let arrayResult = objectValues.filter { element in
                return !objectValues.contains(element)
            }
            print(arrayResult)
        }
//        return isDeleted
    }
    
//    mutating func remove(at indexes: [Int]) {
//        for index in indexes.sorted(by: >) {
//            remove(at: index)
//        }
//    }
//    
//    mutating func remove(at indexes: [IndexPath]) {
//        for index in indexes {
//            remove(at: index.row)
//        }
//    }
}
