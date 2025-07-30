import Foundation

struct NowPlayingMovie: Identifiable {
    let id: Int
    let title: String
    let overview: String
    let backdropUrl: URL?
}

extension NowPlayingMovie {
    init(_ response: MovieResponse) {
        id = response.id
        title = response.title
        overview = response.overview
        backdropUrl = URL(string: "\(Constants.imageBaseURL)\(response.backdropPath)")
    }
}
