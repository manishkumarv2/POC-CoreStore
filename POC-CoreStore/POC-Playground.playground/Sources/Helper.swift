import Foundation

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
