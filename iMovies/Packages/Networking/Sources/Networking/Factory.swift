import Foundation

public protocol NetworkingFactory {
    func makeNetworkService(baseURL: URL, client: NetworkClient?) -> NetworkService
}

public struct DefaultNetworkingFactory: NetworkingFactory {
    public init() { }

    public func makeNetworkService(baseURL: URL, client: NetworkClient?) -> NetworkService {
        return DefaultNetworkService(client: client ?? makeDefaultNetworkClient(baseURL))
    }

    private func makeDefaultNetworkClient(_ baseURL: URL) -> DefaultNetworkClient {
        DefaultNetworkClient(baseURL: baseURL, logger: DefaultNetworkLogger())
    }
}
