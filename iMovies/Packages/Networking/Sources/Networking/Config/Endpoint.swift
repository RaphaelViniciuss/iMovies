import Foundation

public struct Endpoint {
    let path: String
    let method: HTTPMethod
    let headers: [String: String]
    let queryItems: [URLQueryItem]
    let body: Data?

    public init(
        path: String,   
        method: HTTPMethod = .get,
        headers: [String: String] = [:],
        queryItems: [URLQueryItem] = [],
        body: Data? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.queryItems = queryItems
        self.body = body
    }
}
