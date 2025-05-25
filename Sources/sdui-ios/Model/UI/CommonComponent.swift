import SwiftUI

public struct PaddingComponent: Codable {
    public let edge: String
    public let spacing: CGFloat?

    public init(edge: String, spacing: CGFloat? = nil) {
        self.edge = edge
        self.spacing = spacing
    }
}

public struct FrameComponent: Codable {
    public let width: CGFloat?
    public let height: CGFloat?

    public init(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.width = width
        self.height = height
    }
}

public struct ExtreamFrameComponent: Codable {
    public let minWidth: CGFloat?
    public let idealWidth: CGFloat?
    public let maxWidth: CGFloat?
    public let minHeight: CGFloat?
    public let idealHeight: CGFloat?
    public let maxHeight: CGFloat?


    public init(
        minWidth: CGFloat? = nil,
        idealWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        minHeight: CGFloat? = nil,
        idealHeight: CGFloat? = nil,
        maxHeight: CGFloat? = nil
    ) {
        self.minWidth = minWidth
        self.idealWidth = idealWidth
        self.maxWidth = maxWidth
        self.minHeight = minHeight
        self.idealHeight = idealHeight
        self.maxHeight = maxHeight
    }

    enum CodingKeys: String, CodingKey {
        case minWidth, idealWidth, maxWidth, minHeight, idealHeight, maxHeight, alignment
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        func encodeCGFloat(_ value: CGFloat?, forKey key: CodingKeys) throws {
            if let v = value {
                switch v {
                case .greatestFiniteMagnitude: try container.encode("greatestFiniteMagnitude", forKey: key)
                case .infinity: try container.encode("infinity", forKey: key)
                case .leastNonzeroMagnitude: try container.encode("leastNonzeroMagnitude", forKey: key)
                case .leastNormalMagnitude: try container.encode("leastNormalMagnitude", forKey: key)
                case .nan: try container.encode("nan", forKey: key)
                case .pi: try container.encode("pi", forKey: key)
                case .signalingNaN: try container.encode("signalingNaN", forKey: key)
                case .ulpOfOne: try container.encode("ulpOfOne", forKey: key)
                case .zero: try container.encode("zero", forKey: key)
                default: try container.encode(Double(v), forKey: key)
                }
            } else {
                try container.encodeNil(forKey: key)
            }
        }

        try encodeCGFloat(minWidth, forKey: .minWidth)
        try encodeCGFloat(idealWidth, forKey: .idealWidth)
        try encodeCGFloat(maxWidth, forKey: .maxWidth)
        try encodeCGFloat(minHeight, forKey: .minHeight)
        try encodeCGFloat(idealHeight, forKey: .idealHeight)
        try encodeCGFloat(maxHeight, forKey: .maxHeight)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        func decodeCGFloat(forKey key: CodingKeys) throws -> CGFloat? {
            if let doubleValue = try? container.decode(Double.self, forKey: key) {
                return CGFloat(doubleValue)
            } else if let stringValue = try? container.decode(String.self, forKey: key) {
                switch stringValue {
                case "greatestFiniteMagnitude": return .greatestFiniteMagnitude
                case "infinity": return .infinity
                case "leastNonzeroMagnitude": return .leastNonzeroMagnitude
                case "leastNormalMagnitude": return .leastNormalMagnitude
                case "nan": return .nan
                case "pi": return .pi
                case "signalingNaN": return .signalingNaN
                case "ulpOfOne": return .ulpOfOne
                case "zero": return .zero
                default: return CGFloat(Double(stringValue) ?? 0)
                }
            } else {
                return nil
            }
        }

        self.minWidth = try decodeCGFloat(forKey: .minWidth)
        self.idealWidth = try decodeCGFloat(forKey: .idealWidth)
        self.maxWidth = try decodeCGFloat(forKey: .maxWidth)
        self.minHeight = try decodeCGFloat(forKey: .minHeight)
        self.idealHeight = try decodeCGFloat(forKey: .idealHeight)
        self.maxHeight = try decodeCGFloat(forKey: .maxHeight)
    }


}

public protocol CommonComponent: Codable {
    var componentId: String { get }
    var padding: [PaddingComponent]? { get }
    var frame: FrameComponent? { get }
    var extreamFrame: ExtreamFrameComponent? { get }
    var foregroundColor: String? { get }
    var backgroundColor: String? { get }
    var cornerRadius: CGFloat? { get }
    var overlay: SDUIView? { get }
}
