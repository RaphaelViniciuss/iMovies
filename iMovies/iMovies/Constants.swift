import Foundation

struct Constants {
    static var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3") else {
            fatalError("Base URL Not valid")
        }
        return url
    }
}
