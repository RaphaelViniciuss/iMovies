import SwiftUI

@main
struct iMoviesApp: App {
    @State private var container = AppDependency()

    // TODO: Know issue
    /* Currently, the tests are triggering the API, as the app is currently configured to build the home view by default.
     This shouldn't happen to avoid unnecessary calls, as we're testing the app, not the API (for this, we use E2E tests).
     - Solution: Create injection mocks and then make them dynamic based on the target.
     */
    var body: some Scene {
        WindowGroup {
            AppNavigator(container: container)
        }
    }
}
