import Networking
import SwiftUI

struct MovieDetailsDependencyContainer {
    private let network: NetworkService
    private let router: AppRouter

    init(network: NetworkService, router: AppRouter) {
        self.network = network
        self.router = router
    }

    // MARK: - Services
    private func makeMovieDetailsService() -> MovieDetailsService {
        DefaultMovieDetailsService(networkService: network)
    }

    // MARK: - Use Cases
    private func makeMovieDetailsUseCase() -> MovieDetailUseCase {
        DefaultMovieDetailUseCase(service: makeMovieDetailsService())
    }

    // MARK: - ViewModels
    func makeMovieDetailsViewModel(_ id: Int) -> MovieDetailViewModel {
        MovieDetailViewModel(movieId: id, useCase: makeMovieDetailsUseCase())
    }

    // MARK: - Views
    func makeMovieDetailsView(_ id: Int) -> some View {
        MovieDetailView(viewModel: makeMovieDetailsViewModel(id)) {
            router.pop()
        }
    }
}
