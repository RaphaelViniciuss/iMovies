struct MovieDetailResponse: Decodable {
    let id: Int
    let imdbId: String
    let title: String
    let overview: String
    let backdropPath: String
    let posterPath: String
    let runtime: Int
    let releaseDate: String
    let genres: [MovieDetailGenreResponse]
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id, title, overview, genres, runtime
        case imdbId = "imdb_id"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

struct MovieDetailGenreResponse: Decodable {
    let id: Int
    let name: String
}
