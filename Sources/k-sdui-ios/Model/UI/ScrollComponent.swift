import SwiftUI

public struct ScrollComponent: CommonComponent {

    public let componentId: String
    public let padding: [PaddingComponent]?
    public let frame: FrameComponent?
    public let extreamFrame: ExtreamFrameComponent?
    public let foregroundColor: String?
    public let backgroundColor: String?
    public let cornerRadius: CGFloat?
    public let overlay: SDUIView?

    public let axis: String
    public let showIndicator: Bool
    public let containerViews: SDUIView

    public init(componentId: String,
                padding: [PaddingComponent]? = nil,
                frame: FrameComponent? = nil,
                extreamFrame: ExtreamFrameComponent? = nil,
                foregroundColor: String? = nil,
                backgroundColor: String? = nil,
                cornerRadius: CGFloat? = nil,
                overlay: SDUIView? = nil,
                axis: String,
                showIndicator: Bool,
                containerViews: SDUIView) {
        self.componentId = componentId
        self.padding = padding
        self.frame = frame
        self.extreamFrame = extreamFrame
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.overlay = overlay
        self.axis = axis
        self.showIndicator = showIndicator
        self.containerViews = containerViews
    }
}

extension ScrollComponent {

    public func render() -> AnyView {
        return ScrollView(self.axis.convertToScrollAxis(), showsIndicators: self.showIndicator) {
            containerViews.render()
        }
        .applyCommonModifiers(from: self)
        .toAnyView()
    }

}
