struct MovieCreditsResponse: Decodable {
    let id: Int
    let cast: [MovieCastResponse]
}

struct MovieCastResponse: Decodable {
    let id: Int
    let name: String
    let popularity: Double
    let profilePath: String?
    let character: String

    enum CodingKeys: String, CodingKey {
        case id, name, popularity, character
        case profilePath = "profile_path"
    }
}
