import SwiftUI

extension View {

    public func toAnyView() -> AnyView {
        AnyView(self)
    }

    @ViewBuilder
    public func ifLetModifier<T, Content: View>(_ value: T?, transform: (Self, T) -> Content) -> some View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }

    @ViewBuilder
    public func ifModifier<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

}

extension View {

    public func applyPadding(_ paddings: [PaddingComponent]?) -> some View {
        guard let paddings else { return AnyView(self) }

        return paddings.reduce(AnyView(self)) { view, padding in
            let edge = padding.edge.convertToEdge()
            return view.padding(edge, padding.spacing).toAnyView()
        }
    }

    public func applyCommonModifiers(from component: some CommonComponent) -> some View {
        self
            .ifLetModifier(component.foregroundColor) { view, color in
                view.foregroundStyle(Color(hex: color))
            }
            .ifLetModifier(component.frame) { view, frame in
                view.frame(width: frame.width, height: frame.height)
            }
            .ifLetModifier(component.extreamFrame) { view, frame in
                view.frame(
                    minWidth: frame.minWidth,
                    idealWidth: frame.idealWidth,
                    maxWidth: frame.maxWidth,
                    minHeight: frame.minHeight,
                    idealHeight: frame.idealHeight,
                    maxHeight: frame.maxHeight
                )
            }
            .ifLetModifier(component.backgroundColor) { view, color in
                view.background(Color(hex: color))
            }
            .ifLetModifier(component.cornerRadius) { view, radius in
                view.cornerRadius(radius)
            }
            .ifLetModifier(component.overlay) { view, component in
                view.overlay (
                    component.render()
                )
            }
            .applyPadding(component.padding)
    }

}

