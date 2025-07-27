public protocol NetworkClient {
    func request<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T
}
