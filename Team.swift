import Foundation
import FirebaseFirestore

struct Team: Identifiable, Codable, Hashable, Equatable {
    @DocumentID var id: String?
    var name: String
    var season: String
    var playerIDs: [String] = []
    var lineupTemplates: [LineupTemplate] = []

    struct LineupTemplate: Codable, Identifiable, Hashable, Equatable {
        var id: String = ""
        var name: String
        var formation: Formation
        var lineup: [String: FormationPosition]

        enum Formation: String, Codable {
            case fourFourTwo = "4-4-2"
            case fourThreeThree = "4-3-3"
            case threeFiveTwo = "3-5-2"
        }

        enum FormationPosition: String, Codable {
            case gk = "GK"
            case df = "DF"
            case mf = "MF"
            case fw = "FW"
        }
    }
}