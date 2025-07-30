protocol PopularMoviesUseCase {
    func execute() async throws -> [PopularMovie]
}

struct DefaultPopularMoviesUseCase: PopularMoviesUseCase {
    let movieListService: MovieListService
    let genreListService: GenreListService

    func execute() async throws -> [PopularMovie] {
        async let fetchMovieList = await movieListService.fetchPopularMovies()
        async let fetchGenreList = await genreListService.fetchGenresMovieList()
        let movieList = try await fetchMovieList
        let genreList = try await fetchGenreList

        return movieList.compactMap {
            var movie = PopularMovie($0)
            movie.genres = setup(genres: genreList, by: $0.genreIds)
            return movie
        }
    }

    private func setup(genres: [GenreResponse], by ids: [Int]) -> [String] {
        let dict = Dictionary(uniqueKeysWithValues: genres.map { ($0.id, $0.name) })
        return ids.compactMap { dict[$0] }
    }
}
