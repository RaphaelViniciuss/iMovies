import Foundation

struct PopularMovie: Identifiable {
    let id: Int
    let title: String
    var genres: [String] = []
    let poster: URL?
}

extension PopularMovie {
    init(_ response: MovieResponse) {
        id = response.id
        title = response.title
        poster = URL(string: "\(Constants.imageBaseURL)\(response.posterPath)")
    }
}
