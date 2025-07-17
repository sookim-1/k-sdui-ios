import Foundation

public enum ComponentList: String {
    case text
    case button
    case image
    case spacer
    case rectangel
    case roundedRectangle
    case scroll
    case container
    case custom
    case none

    public static func matchText(type: String) -> ComponentList {
        switch type {
        case "text": .text
        case "button": .button
        case "image": .image
        case "spacer": .spacer
        case "rectangle": .rectangel
        case "roundedRectangle": .roundedRectangle
        case "scroll": .scroll
        case "container": .container
        case "custom": .custom
        default: .none
        }
    }
}
