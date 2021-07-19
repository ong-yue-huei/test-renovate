import Foundation

struct User: Decodable, Hashable {
    let id: Int64
    let login: String
    let avatarUrl: URL
    let name: String?
    let followers: Int
    let following: Int
    
    static func ==(lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case name
        case followers
        case following
    }
}
