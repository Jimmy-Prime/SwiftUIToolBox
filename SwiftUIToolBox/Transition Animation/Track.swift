import Foundation

struct Track: Identifiable, Codable {
    let artist: String
    let name: String
    let album: String

    var id: String {
        "\(name) - \(artist)"
    }
}
