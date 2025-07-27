struct DefaultNetworkService: NetworkService {
    private let client: NetworkClient

    init(client: NetworkClient) {
        self.client = client
    }

    func fetch<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T {
        try await client.request(endpoint, responseType: T.self)
    }
}
