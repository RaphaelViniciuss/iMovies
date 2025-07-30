import Foundation
import Networking
import Observation

@Observable
final class AppDependency {
    private let networkService: NetworkService

    var router: AppRouter

    let homeDependencyContainer: HomeDependencyContainer
    let movieDetailsDependencyContainer: MovieDetailsDependencyContainer

    init(
        networkingFactory: NetworkingFactory = DefaultNetworkingFactory(),
        router: AppRouter = AppRouter()
    ) {
        self.networkService = networkingFactory.makeNetworkService(
            baseURL: Constants.baseURL,
            client: nil
        )
        self.router = router
        homeDependencyContainer = HomeDependencyContainer(network: networkService, router: router)
        movieDetailsDependencyContainer = MovieDetailsDependencyContainer(network: networkService, router: router)
    }
}
