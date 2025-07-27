import Foundation

struct DefaultNetworkClient: NetworkClient {
    private let session: URLSession
    private let baseURL: URL
    private let logger: NetworkLogger

    init(baseURL: URL, session: URLSession = .shared, logger: NetworkLogger) {
        self.baseURL = baseURL
        self.session = session
        self.logger = logger
    }

    func request<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T {
        guard var urlComponents = URLComponents(
            url: baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        ) else {
            throw APIError.invalidURL
        }

        urlComponents.queryItems = endpoint.queryItems
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        endpoint.headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        logger.log(request: request)

        let data = try await perform(request: request)

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            logger.log(error: error)
            throw APIError.decodingError(error)
        }
    }

    private func perform(request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await session.data(for: request)
            guard !data.isEmpty else {
                throw APIError.emptyData
            }
            logger.log(response: response, data: data)
            return data
        } catch {
            logger.log(error: error)
            throw APIError.network(error)
        }
    }
}
