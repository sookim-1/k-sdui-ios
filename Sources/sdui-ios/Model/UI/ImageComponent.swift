import SwiftUI

public struct ImageComponent: CommonComponent {

    public let componentId: String
    public let padding: [PaddingComponent]?
    public let frame: FrameComponent?
    public let extreamFrame: ExtreamFrameComponent?
    public let foregroundColor: String?
    public let backgroundColor: String?
    public let cornerRadius: CGFloat?
    public let overlay: SDUIView?

    public let imageURL: String

    public init(componentId: String,
                padding: [PaddingComponent]? = nil,
                frame: FrameComponent? = nil,
                extreamFrame: ExtreamFrameComponent? = nil,
                foregroundColor: String? = nil,
                backgroundColor: String? = nil,
                cornerRadius: CGFloat? = nil,
                overlay: SDUIView? = nil,
                imageURL: String) {
        self.componentId = componentId
        self.padding = padding
        self.frame = frame
        self.extreamFrame = extreamFrame
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.overlay = overlay
        self.imageURL = imageURL
    }

}

extension ImageComponent {

    public func render() -> AnyView {
        if self.imageURL.isValidURL(),
           let url = URL(string: self.imageURL) {
            return AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .ifLetModifier(self.cornerRadius) { view, radius in
                view.clipShape(RoundedRectangle(cornerRadius: radius))
            }
            .applyCommonModifiers(from: self)
            .toAnyView()
        } else {
            return Image(self.imageURL, bundle: nil)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ifLetModifier(self.cornerRadius) { view, radius in
                    view.clipShape(RoundedRectangle(cornerRadius: radius))
                }
                .applyCommonModifiers(from: self)
                .toAnyView()
        }
    }

}
