import SwiftUI

struct AppNavigator: View {
    @Bindable var container: AppDependency

    var body: some View {
        NavigationStack(path: $container.router.path) {
            AppDestination.home.build(container: container)
                .navigationDestination(for: AppDestination.self) { destination in
                    destination.build(container: container)
                }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
