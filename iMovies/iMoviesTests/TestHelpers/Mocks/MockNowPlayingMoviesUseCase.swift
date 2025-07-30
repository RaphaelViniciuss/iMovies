@testable import iMovies

class MockNowPlayingMoviesUseCase: NowPlayingMoviesUseCase {
    var movie: [NowPlayingMovie]?
    var error: Error?

    func execute() async throws -> [NowPlayingMovie] {
        if let error { throw error }
        return movie ?? []
    }
}
