import SwiftUI

enum AppDestination: Hashable {
    case home
    case movieDetail(_ id: Int)

    @ViewBuilder
    func build(container: AppDependency) -> some View {
        switch self {
        case .home:
            container.homeDependencyContainer.makeHomeView()
        case .movieDetail(let id):
            container.movieDetailsDependencyContainer.makeMovieDetailsView(id)
        }
    }
}
