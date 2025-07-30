import Foundation
import Observation

@Observable
final class HomeViewModel {
    let onNavigate: ((AppDestination) -> Void)

    init(
        onNavigate: @escaping ((AppDestination) -> Void)
    ) {
        self.onNavigate = onNavigate
    }
}
