import SwiftUI
import UIKit

// MARK: - 등록 가능한 화면 타입
public enum DestinationType {
    case swiftUI(() -> AnyView)
    case uiKit(() -> UIViewController)
    case url(() -> String)
}

// MARK: - 등록소 (싱글톤)
final public class DestinationRegistry {
    public static let shared = DestinationRegistry()
    private var map: [String: DestinationType] = [:]

    private init() {}

    public func register(_ key: String, as type: DestinationType) {
        map[key] = type
    }

    public func resolve(_ key: String) -> DestinationType? {
        return map[key]
    }
}

// MARK: - UIKit용 화면 전환 헬퍼
final public class ActionDispatcher {

    public weak var navigationController: UINavigationController?
    public static let shared = ActionDispatcher()

    public func handle(_ action: ActionComponent) {
        guard let destination = DestinationRegistry.shared.resolve(action.destination) else {
            print("❌ 등록되지 않은 destination: \(action.destination)")
            return
        }

        switch destination {
        case .uiKit(let makeVC):
            let vc = makeVC()
            switch action.type {
            case "push":
                navigationController?.pushViewController(vc, animated: true)
            case "modal":
                navigationController?.present(vc, animated: true)
            default:
                print("❌ 지원하지 않는 전환 방식: \(action.type)")
            }

        case .swiftUI(let makeView):
            let vc = UIHostingController(rootView: makeView())
            switch action.type {
            case "push":
                navigationController?.pushViewController(vc, animated: true)
            case "modal":
                navigationController?.present(vc, animated: true)
            default:
                print("❌ 지원하지 않는 전환 방식: \(action.type)")
            }
        case .url(let makeURLString):
            let urlString = makeURLString()

            if let url = URL(string: urlString) {
                DispatchQueue.main.async {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
}
