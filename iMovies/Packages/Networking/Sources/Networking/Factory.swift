import Foundation

public struct NetworkingFactory {
    public func makeNetworkService(
        baseURL: URL,
        client: NetworkClient? = nil
    ) -> NetworkService {
        return DefaultNetworkService(client: client ?? makeDefaultNetworkClient(baseURL))
    }

    private func makeDefaultNetworkClient(_ baseURL: URL) -> DefaultNetworkClient {
        DefaultNetworkClient(baseURL: baseURL, logger: DefaultNetworkLogger())
    }
}
