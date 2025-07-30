import Foundation
import Observation

@Observable
final class HomeViewModel {
    let nowPlayingViewModel: NowPlayingMoviesViewModel
    let popularMoviesViewModel: PopularMoviesViewModel
    let onNavigate: ((AppDestination) -> Void)

    init(
        nowPlayingViewModel: NowPlayingMoviesViewModel,
        popularMoviesViewModel: PopularMoviesViewModel,
        onNavigate: @escaping ((AppDestination) -> Void)
    ) {
        self.nowPlayingViewModel = nowPlayingViewModel
        self.popularMoviesViewModel = popularMoviesViewModel
        self.onNavigate = onNavigate
    }
}
