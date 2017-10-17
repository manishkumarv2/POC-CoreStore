import Foundation



extension Bool: Convertible {
    

    public static func convert<T>(fromValue value: T?) throws -> Bool? {
        guard let value = value else { return nil }
        
        if let boolValue = value as? Bool {
            return boolValue
        } else if let intValue = value as? Int {
            return intValue > 0
        }else if let floatValue = value as? Float {
            return floatValue > 0
        } else if let stringValue = value as? String {
            switch stringValue.lowercased() {
            case "true", "t", "yes", "y", "1", "01":
                return true
            case "false", "f", "no", "n", "0", "00":
                return false
            default:
                throw ConversionError.invalidValue
            }
        }
        
        throw ConversionError.unsupportedType
    }
}
