import Foundation

struct MovieCast: Identifiable {
    let id: Int
    let name: String
    let popularity: Double
    let profilePicture: URL?
    let character: String
}

extension MovieCast {
    init(_ response: MovieCastResponse) {
        id = response.id
        name = response.name
        popularity = response.popularity
        profilePicture = URL(string: "\(Constants.imageBaseURL)\(response.profilePath ?? "")")
        character = response.character
    }
}
