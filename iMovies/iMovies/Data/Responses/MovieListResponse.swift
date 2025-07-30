struct MovieListResponse: Decodable {
    let page: Int
    let results: [MovieResponse]
}

struct MovieResponse: Decodable {
    let id: Int
    let title: String
    let overview: String
    let backdropPath: String
    let posterPath: String
    let genreIds: [Int]

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
    }
}
