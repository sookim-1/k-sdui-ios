import SwiftUI

public struct SDUIContainer: Identifiable, CommonComponent {

    public let id = UUID()

    public let componentId: String
    public let padding: [PaddingComponent]?
    public let frame: FrameComponent?
    public let extreamFrame: ExtreamFrameComponent?
    public let foregroundColor: String?
    public let backgroundColor: String?
    public let cornerRadius: CGFloat?
    public let overlay: SDUIView?

    public var layout: SDUILayout
    public var views: [SDUIView]

    enum CodingKeys: String, CodingKey {
        case componentId
        case padding
        case frame
        case extreamFrame
        case foregroundColor
        case backgroundColor
        case cornerRadius
        case overlay

        case layout
        case views
    }

    public init(
        componentId: String,
        padding: [PaddingComponent]? = nil,
        frame: FrameComponent? = nil,
        extreamFrame: ExtreamFrameComponent? = nil,
        foregroundColor: String? = nil,
        backgroundColor: String? = nil,
        cornerRadius: CGFloat? = nil,
        overlay: SDUIView? = nil,
        layout: SDUILayout,
        views: [SDUIView]
    ) {
        self.componentId = componentId
        self.padding = padding
        self.frame = frame
        self.extreamFrame = extreamFrame
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.overlay = overlay
        self.layout = layout
        self.views = views
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.componentId = try container.decode(String.self, forKey: .componentId)
        self.padding = try container.decodeIfPresent([PaddingComponent].self, forKey: .padding)
        self.frame = try container.decodeIfPresent(FrameComponent.self, forKey: .frame)
        self.extreamFrame = try container.decodeIfPresent(ExtreamFrameComponent.self, forKey: .extreamFrame)
        self.foregroundColor = try container.decodeIfPresent(String.self, forKey: .foregroundColor)
        self.backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
        self.cornerRadius = try container.decodeIfPresent(CGFloat.self, forKey: .cornerRadius)
        self.overlay = try container.decodeIfPresent(SDUIView.self, forKey: .overlay)

        self.layout = try container.decode(SDUILayout.self, forKey: .layout)
        self.views = try container.decode([SDUIView].self, forKey: .views)
    }

    public func render() -> AnyView {
        return layout.render(with: views)
            .applyCommonModifiers(from: self)
            .toAnyView()
    }

}
