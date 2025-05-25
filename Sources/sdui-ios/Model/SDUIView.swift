import SwiftUI

public struct SDUIView: Codable, Identifiable {

    public let id = UUID()

    public var type: String
    public let component: CommonComponent

    private enum CodingKeys: String, CodingKey {
        case type, component
    }

    public init(type: String, component: CommonComponent) {
        self.type = type
        self.component = component
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.type = try container.decode(String.self, forKey: .type)
        let list = ComponentList.matchText(type: type)

        switch list {
        case .text: self.component = try container.decode(TextComponent.self, forKey: .component)
        case .button: self.component = try container.decode(ButtonComponent.self, forKey: .component)
        case .image: self.component = try container.decode(ImageComponent.self, forKey: .component)
        case .rectangel: self.component = try container.decode(RectangleComponent.self, forKey: .component)
        case .spacer: self.component = try container.decode(SpacerComponent.self, forKey: .component)
        case .roundedRectangle: self.component = try container.decode(RoundedRectangleComponent.self, forKey: .component)
        case .scroll: self.component = try container.decode(ScrollComponent.self, forKey: .component)
        case .container: self.component = try container.decode(SDUIContainer.self, forKey: .component)
        case .custom: self.component = try container.decode(CustomComponent.self, forKey: .component)
        case .none:
            throw DecodingError.dataCorruptedError(
                forKey: .type,
                in: container,
                debugDescription: "Unknown component type: \(type)"
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)

        switch component {
        case let encodeComponent as TextComponent:
            try container.encode(encodeComponent, forKey: .component)
        case let encodeComponent as ButtonComponent:
            try container.encode(encodeComponent, forKey: .component)
        case let encodeComponent as ImageComponent:
            try container.encode(encodeComponent, forKey: .component)
        case let encodeComponent as SpacerComponent:
            try container.encode(encodeComponent, forKey: .component)
        case let encodeComponent as RectangleComponent:
            try container.encode(encodeComponent, forKey: .component)
        case let encodeComponent as RoundedRectangleComponent:
            try container.encode(encodeComponent, forKey: .component)
        case let encodeComponent as ScrollComponent:
            try container.encode(encodeComponent, forKey: .component)
        case let encodeComponent as SDUIContainer:
            try container.encode(encodeComponent, forKey: .component)
        case let encodeComponent as CustomComponent:
            try container.encode(encodeComponent, forKey: .component)
        default:
            throw EncodingError.invalidValue(
                component,
                EncodingError.Context(
                    codingPath: [CodingKeys.component],
                    debugDescription: "Unknown component type"
                )
            )
        }
    }

}

extension SDUIView {

    public func render() -> AnyView {
        let list = ComponentList.matchText(type: type)

        switch list {
        case .text:
            if let component = component as? TextComponent {
                return component.render()
            }
        case .button:
            if let component = component as? ButtonComponent {
                return component.render()
            }
        case .image:
            if let component = component as? ImageComponent {
                return component.render()
            }
        case .spacer:
            if let component = component as? SpacerComponent {
                return component.render()
            }
        case .rectangel:
            if let component = component as? RectangleComponent {
                return component.render()
            }
        case .roundedRectangle:
            if let component = component as? RoundedRectangleComponent {
                return component.render()
            }
        case .scroll:
            if let component = component as? ScrollComponent {
                return component.render()
            }
        case .container:
            if let component = component as? SDUIContainer {
                return component.render()
            }
        case .custom:
            if let renderer = SDUIView.customRendererMap[type] {
                return renderer(self)
            }
        case .none:
            return Text("Unsupported view type: \(type)")
                .foregroundColor(.red)
                .toAnyView()
        }
        

        return Text("Failed to render component")
            .foregroundColor(.red)
            .toAnyView()
    }

}

extension SDUIView {
    public typealias CustomRenderer = (SDUIView) -> AnyView

    public static var customRendererMap: [String: CustomRenderer] = [:]
}
