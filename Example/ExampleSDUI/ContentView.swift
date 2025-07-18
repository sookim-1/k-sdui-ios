import SwiftUI
import k_sdui_ios

struct ContentView: View {

    @State private var scene: SDUIScene?
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if let scene = scene {
                NavigationView {
                    scene.body
                        .navigationTitle("SDUI Sample")
                }
            } else if let errorMessage = errorMessage {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.orange)

                    Text("Error Parsing")
                        .font(.headline)
                        .padding(.top)

                    Text(errorMessage)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding()
                        .multilineTextAlignment(.center)
                }
                .padding()
            } else {
                ProgressView("Loading...")
            }
        }
        .onAppear {
            parseJSON(fileName: "colorSample2")

            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                parseJSON(fileName: "colorSample1")
            }
        }
    }

    private func parseJSON(fileName: String) {
        let data = SDUIParser.loadJSON(filename: fileName)

        do {
            let decoder = JSONDecoder()
            scene = try decoder.decode(SDUIScene.self, from: data)
        } catch {
            errorMessage = "JSON error: \(error.localizedDescription)"
        }
    }

}

/*
// MARK: - FirebaseRemoteConfig Usage
extension ContentView {

    // import FirebaseRemoteConfig
    //
    // var remoteConfig = RemoteConfig.remoteConfig()
    // var settings = RemoteConfigSettings()

    private func setupRemoteConfigListener() {
        #if DEBUG
            self.settings.minimumFetchInterval = 0
        #endif

        self.remoteConfig.configSettings = settings

        remoteConfig.addOnConfigUpdateListener { configUpdate, error in
            if let error {
                print("Error: \(error)")
                return
            }

            Task {
                await self.activateRemoteConfig()
            }
        }
    }

    // MARK: - RemoteConfig 활성화
    private func activateRemoteConfig() async {
        do {
            try await remoteConfig.fetch()
            try await remoteConfig.activate()
            let data = self.remoteConfig["colorSample1"].jsonValue
            scene = try JSONDecoder().decode(SDUIScene.self, from: data)
        } catch {
            errorMessage = "JSON error: \(error.localizedDescription)"
        }
    }

}
*/
