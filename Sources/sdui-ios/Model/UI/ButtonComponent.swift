import SwiftUI

public struct ActionComponent: Codable {
    public let type: String // modal, push, url
    public let destination: String

    public init(type: String, destination: String) {
        self.type = type
        self.destination = destination
    }

}

public struct ButtonComponent: CommonComponent {

    public let componentId: String
    public let padding: [PaddingComponent]?
    public let frame: FrameComponent?
    public let extreamFrame: ExtreamFrameComponent?
    public let foregroundColor: String?
    public let backgroundColor: String?
    public let cornerRadius: CGFloat?
    public let overlay: SDUIView?

    public let text: String
    public let action: ActionComponent?
    public let customViews: SDUIView?

    public init(componentId: String,
                padding: [PaddingComponent]? = nil,
                frame: FrameComponent? = nil,
                extreamFrame: ExtreamFrameComponent? = nil,
                foregroundColor: String? = nil,
                backgroundColor: String? = nil,
                cornerRadius: CGFloat? = nil,
                overlay: SDUIView? = nil,
                text: String,
                action: ActionComponent? = nil,
                customViews: SDUIView? = nil
    ) {
        self.componentId = componentId
        self.padding = padding
        self.frame = frame
        self.extreamFrame = extreamFrame
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.overlay = overlay
        self.text = text
        self.action = action
        self.customViews = customViews
    }

}

extension ButtonComponent {

    public func render() -> AnyView {
        var tempView: AnyView
        let action = self.action

        let handler = {
            if let action = action {
                ActionDispatcher.shared.handle(action)
            }
        }

        if let customButton = self.customViews {
            tempView = Button(action: handler) {
                customButton.render()
            }
            .toAnyView()
        } else {
            tempView = Button(action: handler) {
                Text(self.text)
            }
            .toAnyView()
        }

        return tempView
            .applyCommonModifiers(from: self)
            .toAnyView()
    }


}

