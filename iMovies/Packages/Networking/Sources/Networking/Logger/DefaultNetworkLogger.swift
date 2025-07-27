import Foundation
import os

#if DEBUG
struct DefaultNetworkLogger: NetworkLogger {
    private let logger: Logger

    public init(subsystem: String = Bundle.main.bundleIdentifier ?? "Networking", category: String = "  ") {
        self.logger = Logger(subsystem: subsystem, category: category)
    }

    public func log(request: URLRequest) {
        var output = """
        [Request]
        URL: \(request.url?.absoluteString ?? "nil")
        Method: \(request.httpMethod ?? "nil")
        Headers: \(request.allHTTPHeaderFields ?? [:])
        """

        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            output += "\nBody: \(bodyString)"
        }

        logger.debug("\(output, privacy: .public)")
    }

    public func log(response: URLResponse, data: Data) {
        guard let http = response as? HTTPURLResponse else { return }

        var output = """
        [Response]
        Status: \(http.statusCode)
        """

        if let json = try? JSONSerialization.jsonObject(with: data),
           let formatted = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
           let bodyString = String(data: formatted, encoding: .utf8) {
            output += "\nBody:\n\(bodyString)"
        } else if let body = String(data: data, encoding: .utf8) {
            output += "\nBody:\n\(body)"
        }

        logger.debug("\(output, privacy: .public)")
    }

    public func log(error: Error) {
        logger.error("[Error] \(error.localizedDescription, privacy: .public)")
    }
}
#endif
