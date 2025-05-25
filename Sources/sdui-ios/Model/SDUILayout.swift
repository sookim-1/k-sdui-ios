import SwiftUI

public struct SDUILayout: Codable {
    public var type: String
    public var spacing: CGFloat?
    public var alignment: String

    enum CodingKeys: String, CodingKey {
        case type, spacing, alignment
    }

    public init(
        type: String,
        spacing: CGFloat? = nil,
        alignment: String
    ) {
        self.type = type
        self.spacing = spacing
        self.alignment = alignment
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.spacing = try container.decodeIfPresent(CGFloat.self, forKey: .spacing)
        self.alignment = try container.decode(String.self, forKey: .alignment)
    }

    public func render(with views: [SDUIView]) -> AnyView {
        switch self.type {
        case "h":
            return HStack(alignment: self.verticalAlignment,
                          spacing: self.spacing) {
                ForEach(views.indices, id: \.self) { index in
                    views[index].render()
                }
            }.toAnyView()
        case "lh":
            return LazyHStack(alignment: self.verticalAlignment,
                          spacing: self.spacing) {
                ForEach(views.indices, id: \.self) { index in
                    views[index].render()
                }
            }.toAnyView()
        case "v":
            return VStack(alignment: self.horizontalAlignment,
                          spacing: self.spacing) {
                ForEach(views.indices, id: \.self) { index in
                    views[index].render()
                }
            }.toAnyView()
        case "lv":
            return LazyVStack(alignment: self.horizontalAlignment,
                          spacing: self.spacing) {
                ForEach(views.indices, id: \.self) { index in
                    views[index].render()
                }
            }.toAnyView()
        case "z":
            return ZStack(alignment: self.defaultAlignment) {
                ForEach(views.indices, id: \.self) { index in
                    views[index].render()
                }
            }.toAnyView()
        default: return Text("Layout Render Error")
                .toAnyView()
        }
    }

    private var defaultAlignment: Alignment {
        return alignment.convertToDefaultAlignment()
    }

    private var verticalAlignment: VerticalAlignment {
        return alignment.convertToVerticalAlignment()
    }

    private var horizontalAlignment: HorizontalAlignment {
        return alignment.convertToHorizontalAlignment()
    }


}
