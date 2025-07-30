@testable import iMovies

class MockMovieListService: MovieListService {
    var movie: [MovieResponse]?
    var error: Error?

    func fetchNowPlayingMovies() async throws -> [MovieResponse] {
        try fetchMock()
    }
    
    func fetchPopularMovies() async throws -> [MovieResponse] {
        try fetchMock()
    }

    private func fetchMock() throws -> [MovieResponse] {
        if let error { throw error }
        return movie ?? []
    }
}
