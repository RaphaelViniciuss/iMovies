import Networking
import Foundation

protocol MovieDetailsService {
    func fetchMovieDetail(for id: Int) async throws -> MovieDetailResponse
    func fetchCast(for id: Int) async throws -> [MovieCastResponse]
}

struct DefaultMovieDetailsService: MovieDetailsService {
    let networkService: NetworkService

    func fetchMovieDetail(for id: Int) async throws -> MovieDetailResponse {
        let endpoint = Endpoint(path: "/movie/\(id)", headers: Constants.auth)
        return try await networkService.fetch(endpoint, as: MovieDetailResponse.self)
    }

    func fetchCast(for id: Int) async throws -> [MovieCastResponse] {
        let endpoint = Endpoint(path: "/movie/\(id)/credits", headers: Constants.auth)
        return try await networkService.fetch(endpoint, as: MovieCreditsResponse.self).cast
    }
}
