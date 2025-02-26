import Foundation
import FirebaseFirestore

struct Game: Identifiable, Codable {
    @DocumentID var id: String?
    var season: String
    var date: Date
    var lineup: [String: Position] = [:]
    var substitutes: [String] = []
    var formation: Formation = .elevenAside
    var events: [GameEvent] = []
    var homeTeamID: String
    var awayTeamID: String
    var homeTeamName: String
    var awayTeamName: String
    var homeScore: Int = 0
    var awayScore: Int = 0
    var format: GameFormat = GameFormat()
    var status: MatchStatus = .upcoming

    enum Formation: String, Codable {
        case sevenAside = "7-a-side"
        case nineAside = "9-a-side"
        case elevenAside = "11-a-side"
    }

    struct GameEvent: Codable, Identifiable {
        var id = UUID()
        var type: EventType
        var minute: Int
        var playerID: String
        var details: String?

        enum EventType: String, Codable {
            case goal, assist, card, substitution, positionChange
        }
    }

    enum Position: String, Codable {
        case gk = "GK"
        case df = "DF"
        case mf = "MF"
        case fw = "FW"
    }

    enum MatchStatus: String, Codable {
        case upcoming, nowPlaying, ended
    }
}

struct GameFormat: Codable {
    var playersAside: Int = 11
    var halfLength: Int = 45
    var extraTimeOption: ExtraTimeOption = .none
    var penaltyShootout: Bool = false

    enum ExtraTimeOption: String, Codable {
        case none, goldenGoal, twoHalves
    }
}