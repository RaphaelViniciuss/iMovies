import Foundation

struct Constants {
    static var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3") else {
            fatalError("Base URL Not valid")
        }
        return url
    }

    static var imageBaseURL: URL {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500") else {
            fatalError("Image Base URL Not valid")
        }
        return url
    }

    // TODO: Interceptor/Token logic
    // Ideally, Networking package would accept interceptor injection.
    // This way, the app could have a manager that controls the auth token
    // Then add the token to all requests instead of add it on each service as currently
    static var auth: [String : String] {
        ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkN2Y4NmM4NmQ1NDA5ODE2MWY2YjI0ODliMDMxMjM3ZCIsIm5iZiI6MTY4NTgxMjMxNC42MDUsInN1YiI6IjY0N2I3NDVhY2FlZjJkMDEzNjJiMWZhMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.oAmpEmonaJVnYwNGDhhS24YlDR6PTigxtw-4zUDzfZ0"]
    }
}
