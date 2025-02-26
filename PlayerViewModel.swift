import Foundation
import FirebaseFirestore

class PlayerViewModel: ObservableObject {
    @Published var players: [Player] = []
    private let db = Firestore.firestore()
    
    func addPlayer(number: Int, firstName: String, lastName: String, teamID: String = "defaultTeamID") {
        let newPlayer = Player(
            id: nil,
            number: number,
            firstName: firstName,
            lastName: lastName,
            isCaptain: false,
            teamID: teamID,
            statsBySeason: [:]
        )
        
        // Save to Firestore
        do {
            try db.collection("teams").document(teamID)
                .collection("players").addDocument(from: newPlayer)
        } catch {
            print("Error adding player: \(error)")
        }
        
        players.append(newPlayer)
    }
    
    func fetchPlayers(for teamID: String = "defaultTeamID") {
        db.collection("teams").document(teamID).collection("players")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching players: \(error)")
                    return
                }
                self.players = snapshot?.documents.compactMap { try? $0.data(as: Player.self) } ?? []
            }
    }
}