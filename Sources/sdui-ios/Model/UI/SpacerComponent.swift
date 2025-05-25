import SwiftUI

public struct SpacerComponent: CommonComponent {

    public let componentId: String
    public let padding: [PaddingComponent]?
    public let frame: FrameComponent?
    public let extreamFrame: ExtreamFrameComponent?
    public let foregroundColor: String?
    public let backgroundColor: String?
    public let cornerRadius: CGFloat?
    public let overlay: SDUIView?

    public init(componentId: String,
                padding: [PaddingComponent]? = nil,
                frame: FrameComponent? = nil,
                extreamFrame: ExtreamFrameComponent? = nil,
                foregroundColor: String? = nil,
                backgroundColor: String? = nil,
                cornerRadius: CGFloat? = nil,
                overlay: SDUIView? = nil
    ) {
        self.componentId = componentId
        self.padding = padding
        self.frame = frame
        self.extreamFrame = extreamFrame
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.overlay = overlay
    }

}

extension SpacerComponent {
    
    public func render() -> AnyView {
        return Spacer()
            .applyCommonModifiers(from: self)
            .toAnyView()
    }

}
