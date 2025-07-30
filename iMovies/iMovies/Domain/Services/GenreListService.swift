import Networking

protocol GenreListService {
    func fetchGenresMovieList() async throws -> [GenreResponse]
}

struct DefaultGenreListService: GenreListService {
    let networkService: NetworkService

    func fetchGenresMovieList() async throws -> [GenreResponse] {
        let endpoint = Endpoint(path: "/genre/movie/list", headers: Constants.auth)
        return try await networkService.fetch(endpoint, as: GenreListResponse.self).genres
    }
}
