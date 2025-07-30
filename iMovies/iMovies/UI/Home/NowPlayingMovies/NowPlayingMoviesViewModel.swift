import Foundation
import Observation

@Observable
final class NowPlayingMoviesViewModel {
    private let nowPlayingUseCase: NowPlayingMoviesUseCase
    private(set) var nowPlayingMovies: [NowPlayingMovie] = []

    var currentPage = 0
    let autoDragInterval: TimeInterval = 6

    init(nowPlayingUseCase: NowPlayingMoviesUseCase) {
        self.nowPlayingUseCase = nowPlayingUseCase
    }

    func load() async {
        do {
            nowPlayingMovies = try await nowPlayingUseCase.execute().prefix(6).compactMap { $0 }
        } catch {
            // TODO: handle error state
            print("[Error]:: NowPlayingMoviesViewModel: \(error)")
        }
    }
}
