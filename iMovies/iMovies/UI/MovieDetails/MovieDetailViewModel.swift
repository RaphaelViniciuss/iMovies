import Observation

@Observable
final class MovieDetailViewModel {
    private let useCase: MovieDetailUseCase
    private let movieId: Int

    var movie: Movie?

    init(movieId: Int, useCase: MovieDetailUseCase) {
        self.movieId = movieId
        self.useCase = useCase
    }

    func load() async {
        do {
            movie = try await useCase.execute(for: movieId)
        } catch {
            print("❌ MovieDetailViewModel: \(error)")
        }
    }
}
