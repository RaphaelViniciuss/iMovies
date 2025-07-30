import Testing

@testable import iMovies

struct NowPlayingMoviesViewModelTests {
    @Test func test_load() async {
        let mockUseCase = MockNowPlayingMoviesUseCase()
        mockUseCase.movie = .fixture(with: 4)
        let sut = NowPlayingMoviesViewModel(nowPlayingUseCase: mockUseCase)

        await sut.load()

        #expect(sut.nowPlayingMovies.count == 4)
        #expect(sut.nowPlayingMovies.first?.title == "Fixture Movie Title \(0)")
    }
}

