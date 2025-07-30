import Testing

@testable import iMovies

struct NowPlayingMoviesUseCaseTests {
    @Test func test_execute() async throws {
        let service = MockMovieListService()
        service.movie = .fixture(with: 6)
        let sut = DefaultNowPlayingMoviesUseCase(service: service)

        let result = try await sut.execute()

        #expect(result.count == 6)
        result.enumerated().forEach { index, movie in
            #expect(movie.title == "Fixture MovieResponse \(index)")
        }
    }
}
