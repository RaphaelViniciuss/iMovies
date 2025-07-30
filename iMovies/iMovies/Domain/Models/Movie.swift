import Foundation

struct Movie {
    let id: Int
    let title: String
    let overview: String
    let poster: URL?
    let releaseDate: Date
    let runtime: Int
    let genre: String
    let voteAverage: Double
    var cast: [MovieCast] = []
}

extension Movie {
    init(_ response: MovieDetailResponse) {
        id = response.id
        title = response.title
        overview = response.overview
        poster = URL(string: "\(Constants.imageBaseURL)\(response.posterPath)")
        runtime = response.runtime
        genre = response.genres.first?.name ?? ""
        voteAverage = response.voteAverage

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        releaseDate = dateFormatter.date(from: response.releaseDate) ?? Date()
    }
}
