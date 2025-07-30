@testable import iMovies

extension NowPlayingMovie {
    static func fixture(id: Int = 0) -> Self {
        .init(id: id, title: "Fixture Movie Title \(id)", overview: "Fixture Overview", backdropUrl: nil)
    }
}

extension Array where Element == NowPlayingMovie {
    static func fixture(with max: Int = 0) -> Self {
        (0..<max).map { .fixture(id: $0) }
    }
}
