import SwiftUI

public struct SDUIScene: Codable, Identifiable {

    public let id = UUID()
    public var hasNavigationBar: Bool
    public var container: SDUIContainer

    enum CodingKeys: String, CodingKey {
        case hasNavigationBar, container
    }

    public init(hasNavigationBar: Bool, container: SDUIContainer) {
        self.hasNavigationBar = hasNavigationBar
        self.container = container
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.hasNavigationBar = try container.decode(Bool.self, forKey: .hasNavigationBar)
        self.container = try container.decode(SDUIContainer.self, forKey: .container)
    }

    // View 프로토콜 준수
    public var body: some View {
        ScrollView(showsIndicators: false) {
            container.render()
        }
        .navigationBarHidden(!hasNavigationBar)
    }

}
