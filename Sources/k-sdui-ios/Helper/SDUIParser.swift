import Foundation

public class SDUIParser {

    public static func prettyPrintedJSON(from data: Data) -> String? {
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: [])
            let prettyData = try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted])
            return String(data: prettyData, encoding: .utf8)
        } catch {
            print("❌ Failed to pretty print JSON:", error)
            return nil
        }
    }

    public static func loadJSON(filename: String) -> Data {
        guard let path = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("번들 오류")
        }

        do {
            let data = try Data(contentsOf: path)

            return data
        } catch {
            print("에러 발생")
            fatalError("디코딩 오류")
        }
    }

    public static func debugJSON<T: Decodable>(from jsonString: String, as type: T.Type) -> (decoded: T?, error: Error?) {
        guard let data = jsonString.data(using: .utf8)
        else {
            return (nil, NSError(domain: "JSONDebug", code: 1, userInfo: [NSLocalizedDescriptionKey: "Cannot convert string to data"]))
        }

        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.debugDecode(type, from: data)
            return (decoded, nil)
        } catch {
            return (nil, error)
        }
    }

}
