//
//  TestViewController.swift
//  POC-CoreStore
//
//  Created by Manish Kumar on 10/17/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation
import UIKit

/// Thrown when a conversion operation fails.
public enum ConversionError: Error {
    
    /// TODOC
    case unsupportedType
    
    /// TODOC
    case invalidValue
}

/// An object that can attempt to convert values of unknown types to its own type.
public protocol Convertible {
    
    /// TODOC
    static func convert<T>(fromValue value: T?) throws -> Self?
}

class TestViewController: UIViewController {
    override func viewDidLoad() {
        let boolString: String = "Y"
//        let isBool: Bool = true
        do{
            print(try Bool.convert(fromValue: boolString) ?? false)
        }catch(let error){
            print(error)
        }
    }
}


extension Bool: Convertible {
    
    public static func convert<T>(fromValue value: T?) throws -> Bool? {
        guard let value = value else { return nil }
        
        if let boolValue = value as? Bool {
            return boolValue
        } else if let intValue = value as? Int {
            return intValue > 0
        } else if let stringValue = value as? String {
            switch stringValue.lowercased() {
            case "true", "t", "yes", "y":
                return true
            case "false", "f", "no", "n":
                return false
            default:
                throw ConversionError.invalidValue
            }
        }
        
        throw ConversionError.unsupportedType
    }
}
