import Observation
import SwiftUI

@Observable
final class AppRouter {
    var path = NavigationPath()

    func navigate(to destination: AppDestination) {
        path.append(destination)
    }

    func pop() {
        path.removeLast()
    }

    func reset() {
        path = NavigationPath()
    }
}
