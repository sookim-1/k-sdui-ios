import SwiftUI


public struct StrokeComponent: Codable {
    public let strokeColor: String
    public let lineWidth: CGFloat

    public init(strokeColor: String, lineWidth: CGFloat) {
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
    }
}

public struct RoundedRectangleComponent: CommonComponent {

    public let componentId: String
    public let padding: [PaddingComponent]?
    public let frame: FrameComponent?
    public let extreamFrame: ExtreamFrameComponent?
    public let foregroundColor: String?
    public let backgroundColor: String?
    public let cornerRadius: CGFloat?
    public let overlay: SDUIView?
    
    public let strokeComponent: StrokeComponent?

    public init(componentId: String,
                padding: [PaddingComponent]? = nil,
                frame: FrameComponent? = nil,
                extreamFrame: ExtreamFrameComponent? = nil,
                foregroundColor: String? = nil,
                backgroundColor: String? = nil,
                cornerRadius: CGFloat? = nil,
                overlay: SDUIView? = nil,
                strokeComponent: StrokeComponent? = nil
    ) {
        self.componentId = componentId
        self.padding = padding
        self.frame = frame
        self.extreamFrame = extreamFrame
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.overlay = overlay
        self.strokeComponent = strokeComponent
    }

}

extension RoundedRectangleComponent {

    public func render() -> AnyView {
        return RoundedRectangle(cornerRadius: self.cornerRadius ?? 0)
            .ifLetModifier(self.strokeComponent) { view, storkeItem in
                view.stroke(Color(hex: storkeItem.strokeColor), lineWidth: storkeItem.lineWidth)
            }
            .toAnyView()
    }

}
