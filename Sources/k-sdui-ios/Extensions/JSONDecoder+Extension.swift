import Foundation

public extension JSONDecoder {

    /// Debug-friendly JSON decoding that provides more detailed error messages
    /// - Parameters:
    ///   - type: The type to decode to
    ///   - data: The JSON data to decode
    /// - Returns: The decoded object
    /// - Throws: Detailed error information if decoding fails
    func debugDecode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        do {
            return try self.decode(type, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted: \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            throw DecodingError.dataCorrupted(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key.stringValue)' not found: \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            throw DecodingError.keyNotFound(key, context)
        } catch let DecodingError.valueNotFound(type, context) {
            print("Value of type \(type) not found: \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            throw DecodingError.valueNotFound(type, context)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type mismatch for type \(type): \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
            throw DecodingError.typeMismatch(type, context)
        } catch {
            print("Unknown decoding error: \(error)")
            throw error
        }
    }

}
