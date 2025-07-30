import Observation

@Observable
final class PopularMoviesViewModel {
    private let popularMoviesUseCase: PopularMoviesUseCase
    private(set) var popularMovies: [PopularMovie] = []

    init(popularMoviesUseCase: PopularMoviesUseCase) {
        self.popularMoviesUseCase = popularMoviesUseCase
    }

    func load() async {
        do {
            popularMovies = try await popularMoviesUseCase.execute()
        } catch {
            // TODO: handle error state
            print("[Error]:: PopularMoviesViewModel: \(error)")
        }
    }
}
