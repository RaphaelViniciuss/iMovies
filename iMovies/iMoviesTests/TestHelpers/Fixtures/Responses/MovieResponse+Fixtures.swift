@testable import iMovies

extension MovieResponse {
    static func fixture(id: Int = 0) -> Self {
        .init(
            id: id,
            title: "Fixture MovieResponse \(id)",
            overview: "",
            backdropPath: "",
            posterPath: "",
            genreIds: []
        )
    }
}

extension Array where Element == MovieResponse {
    static func fixture(with max: Int = 0) -> Self {
        (0..<max).map { .fixture(id: $0) }
    }
}
