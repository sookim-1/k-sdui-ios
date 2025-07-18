import SwiftUI
import k_sdui_ios

public struct MockGenerator {

    public func makeMainScene(views: [SDUIView]) -> SDUIScene {
        let mainLayout = SDUILayout(type: "v", alignment: "leading")
        let mainContainer = SDUIContainer(componentId: "mainContainer", layout: mainLayout, views: views)
        let testScene = SDUIScene(hasNavigationBar: false, container: mainContainer)
        return testScene
    }

}

// Usage
func generateMockJSON() -> String {
    let generator = MockGenerator()
    let sampleScene = generator.makeMainScene(views: [])

    SDUIView.customRendererMap["custom"] = { view in
        return ContentView()
            .frame(height: UIScreen.main.bounds.height * 0.1)
            .padding(.vertical)
            .toAnyView()
    }

    do {
        let encodeData = try JSONEncoder().encode(sampleScene)

        guard let jsonString = String(data: encodeData, encoding: .utf8) else { return "" }

        print("Mock JSON:\n\(jsonString)")
        return jsonString
    } catch {
        print("error")
    }

    return ""
}
