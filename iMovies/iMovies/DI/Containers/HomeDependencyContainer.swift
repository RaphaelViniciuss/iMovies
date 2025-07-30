import SwiftUI
import Networking

struct HomeDependencyContainer {
    private let network: NetworkService
    private let router: AppRouter

    init(network: NetworkService, router: AppRouter) {
        self.network = network
        self.router = router
    }
    // MARK: - ViewModels
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
        ) { route in
            router.navigate(to: route)
        }
    }
    // MARK: - Views
    func makeHomeView() -> some View {
        HomeView(viewModel: makeHomeViewModel())
    }
}
