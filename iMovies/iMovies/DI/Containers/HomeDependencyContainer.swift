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

    private func makeGenreListService() -> GenreListService {
        DefaultGenreListService(networkService: network)
    }

    // MARK: - Use Cases
    private func makeNowPlayingMoviesUseCase() -> NowPlayingMoviesUseCase {
        DefaultNowPlayingMoviesUseCase(service: makeMovieListService())
    }

    private func makePopularMoviesUseCase() -> PopularMoviesUseCase {
        DefaultPopularMoviesUseCase(
            movieListService: makeMovieListService(),
            genreListService: makeGenreListService()
        )
    }

    // MARK: - ViewModels
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            nowPlayingViewModel: makeNowPlayingMoviesViewModel(),
            popularMoviesViewModel: makePopularMoviesViewModel()
        ) { route in
            router.navigate(to: route)
        }
    }

    func makeNowPlayingMoviesViewModel() -> NowPlayingMoviesViewModel {
        NowPlayingMoviesViewModel(nowPlayingUseCase: makeNowPlayingMoviesUseCase())
    }

    func makePopularMoviesViewModel() -> PopularMoviesViewModel {
        PopularMoviesViewModel(popularMoviesUseCase: makePopularMoviesUseCase())
    }

    // MARK: - Views
    func makeHomeView() -> some View {
        HomeView(viewModel: makeHomeViewModel())
    }
}
