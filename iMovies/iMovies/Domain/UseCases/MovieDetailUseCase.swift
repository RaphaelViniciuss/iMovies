protocol MovieDetailUseCase {
    func execute(for id: Int) async throws -> Movie
}

struct DefaultMovieDetailUseCase: MovieDetailUseCase {
    let service: MovieDetailsService

    func execute(for id: Int) async throws -> Movie {
        async let fetchDetail = await service.fetchMovieDetail(for: id)
        async let fetchCast = await service.fetchCast(for: id)
        let movieDetail = try await fetchDetail
        let cast = try await fetchCast

        var movie = Movie(movieDetail)
        movie.cast = cast
            .filter { $0.profilePath != nil }
            .prefix(15)
            .compactMap { MovieCast($0) }

        return movie
    }
}
