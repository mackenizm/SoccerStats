import Foundation
import FirebaseFirestore

/// A model representing a single player's data.
struct Player: Identifiable, Codable {
    @DocumentID var id: String?
    var number: Int
    var firstName: String
    var lastName: String
    var isCaptain: Bool = false
    var teamID: String?
    var statsBySeason: [String: SeasonStats]?
}

/// Example of a sub-struct for storing stats:
struct SeasonStats: Codable {
    var goals: Int
    var assists: Int
    // add any other stats you need
}
