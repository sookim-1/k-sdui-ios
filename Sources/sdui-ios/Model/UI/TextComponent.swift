import SwiftUI

public struct FontComponent: Codable {
    public let fontName: String
    public let fontSize: CGFloat

    public init(fontName: String, fontSize: CGFloat) {
        self.fontName = fontName
        self.fontSize = fontSize
    }
}

public struct TextComponent: CommonComponent {

    public let componentId: String
    public let padding: [PaddingComponent]?
    public let frame: FrameComponent?
    public let extreamFrame: ExtreamFrameComponent?
    public let foregroundColor: String?
    public let backgroundColor: String?
    public let cornerRadius: CGFloat?
    public let overlay: SDUIView?
    
    public let text: String
    public let font: FontComponent?
    public let lineLimit: Int?

    public init(componentId: String,
                padding: [PaddingComponent]? = nil,
                frame: FrameComponent? = nil,
                extreamFrame: ExtreamFrameComponent? = nil,
                foregroundColor: String? = nil,
                backgroundColor: String? = nil,
                cornerRadius: CGFloat? = nil,
                overlay: SDUIView? = nil,
                text: String,
                font: FontComponent? = nil,
                lineLimit: Int? = nil) {
        self.componentId = componentId
        self.padding = padding
        self.frame = frame
        self.extreamFrame = extreamFrame
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.overlay = overlay
        self.text = text
        self.font = font
        self.lineLimit = lineLimit
    }

}

extension TextComponent {

    public func render() -> AnyView {
        return Text(self.text)
            .lineLimit(self.lineLimit)
            .ifLetModifier(self.font) { view, font in
                view.font(.custom(font.fontName, size: font.fontSize))
            }
            .applyCommonModifiers(from: self)
            .toAnyView()
    }

}
