import SwiftUI
import Networking

struct HomeDependencyContainer {
    private let network: NetworkService
    private let router: AppRouter

    init(network: NetworkService, router: AppRouter) {
        self.network = network
        self.router = router
    }

    // MARK: - Services
    private func makeMovieListService() -> MovieListService {
        DefaultMovieListService(networkService: network)
    }
    // MARK: - Use Cases
    private func makeNowPlayingMoviesUseCase() -> NowPlayingMoviesUseCase {
        DefaultNowPlayingMoviesUseCase(service: makeMovieListService())
    }
    // MARK: - ViewModels
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            nowPlayingViewModel: makeNowPlayingMoviesViewModel(),
        ) { route in
            router.navigate(to: route)
        }
    }

    func makeNowPlayingMoviesViewModel() -> NowPlayingMoviesViewModel {
        NowPlayingMoviesViewModel(nowPlayingUseCase: makeNowPlayingMoviesUseCase())
    }
    // MARK: - Views
    func makeHomeView() -> some View {
        HomeView(viewModel: makeHomeViewModel())
    }
}
