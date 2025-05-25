import SwiftUI

public extension String {

    func convertToScrollAxis() -> Axis.Set {
        switch self {
        case "h": return .horizontal
        case "v": return .vertical
        default: return .vertical
        }
    }

    func convertToEdge() -> Edge.Set {
        switch self {
        case "top": return .top
        case "leading": return .leading
        case "bottom": return .bottom
        case "trailing": return .trailing
        case "all": return .all
        case "horizontal": return .horizontal
        case "vertical": return .vertical
        default: return .all
        }
    }

    func convertToDefaultAlignment() -> Alignment {
        switch self {
        case "topLeading": return .topLeading
        case "top": return .top
        case "leading": return .leading
        case "center": return .center
        case "trailing": return .trailing
        case "bottomLeading": return .bottomLeading
        case "bottom": return .bottom
        case "bottomTrailing": return .bottomTrailing
        default: return .center
        }
    }

    func convertToVerticalAlignment() -> VerticalAlignment {
        switch self {
        case "center": return .center
        case "top": return .top
        case "bottom": return .bottom
        default: return .center
        }
    }

    func convertToHorizontalAlignment() -> HorizontalAlignment {
        switch self {
        case "center": return .center
        case "left", "leading": return .leading
        case "right", "trailing": return .trailing
        default: return .center
        }
    }

}

public extension String {

    func isValidURL() -> Bool {
        let protocols = ["http://", "https://", "wss://", "ws://", "ftp://", "file://", "data:"]
        return protocols.contains { self.hasPrefix($0) }
    }

}
