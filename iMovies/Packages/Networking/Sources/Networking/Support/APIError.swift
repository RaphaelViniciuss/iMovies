import Foundation

public enum APIError: Error, LocalizedError {
    case invalidURL
    case decodingError(Error)
    case network(Error)
    case emptyData
    case custom(String)
    case unknown(Error)

    public var description: String? {
        switch self {
        case .invalidURL:
            "URL inválida."
        case .decodingError(let error):
            "Erro ao decodificar resposta: \(error.localizedDescription)"
        case .network(let error):
            "Erro de rede: \(error.localizedDescription)"
        case .emptyData:
            "Resposta sem dados."
        case .custom(let message):
            message
        case .unknown(let error):
            "\(error.localizedDescription)"
        }
    }
}
