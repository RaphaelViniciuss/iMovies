public protocol NetworkService {
    func fetch<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T
}
