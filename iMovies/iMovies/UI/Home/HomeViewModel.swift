import Foundation
import Observation

@Observable
final class HomeViewModel {
    let nowPlayingViewModel: NowPlayingMoviesViewModel
    let onNavigate: ((AppDestination) -> Void)

    init(
        nowPlayingViewModel: NowPlayingMoviesViewModel,
        onNavigate: @escaping ((AppDestination) -> Void)
    ) {
        self.nowPlayingViewModel = nowPlayingViewModel
        self.onNavigate = onNavigate
    }
}
