protocol NowPlayingMoviesUseCase {
    func execute() async throws -> [NowPlayingMovie]
}

struct DefaultNowPlayingMoviesUseCase: NowPlayingMoviesUseCase {
    let service: MovieListService

    func execute() async throws -> [NowPlayingMovie] {
        let data = try await service.fetchNowPlayingMovies()
        return data.compactMap { NowPlayingMovie($0) }
    }
}


