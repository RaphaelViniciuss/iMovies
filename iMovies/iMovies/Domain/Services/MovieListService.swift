import Networking

protocol MovieListService {
    func fetchNowPlayingMovies() async throws -> [MovieResponse]
}

struct DefaultMovieListService: MovieListService {
    let networkService: NetworkService

    func fetchNowPlayingMovies() async throws -> [MovieResponse] {
        let endpoint = Endpoint(path: "/movie/now_playing", headers: Constants.auth)
        return try await networkService.fetch(endpoint, as: MovieListResponse.self).results
    }

}
