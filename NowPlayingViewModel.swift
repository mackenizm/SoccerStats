import FirebaseFirestore
import Combine

class NowPlayingViewModel: ObservableObject {
    @Published var game: Game
    @Published var homePlayers: [Player] = []
    @Published var matchTime: Int = 0
    @Published var isMatchRunning: Bool = false
    private var matchTimer: Timer?
    private let db = Firestore.firestore()

    init(game: Game) {
        self.game = game
        fetchHomePlayers()
    }

    func fetchHomePlayers() {
        let homeTeamID = game.homeTeamID
        db.collection("teams")
            .document(homeTeamID)
            .collection("players")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching players: \(error.localizedDescription)")
                    return
                }
                self.homePlayers = snapshot?.documents.compactMap { try? $0.data(as: Player.self) } ?? []
            }
    }

    func startMatchTimer() {
        stopMatchTimer()
        isMatchRunning = true
        matchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.matchTime += 1
        }
    }

    func stopMatchTimer() {
        matchTimer?.invalidate()
        matchTimer = nil
        isMatchRunning = false
    }

    func saveGame(for userID: String) {
        do {
            let gameRef = db.collection("users")
                .document(userID)
                .collection("games")
                .document(game.id ?? UUID().uuidString)
            try gameRef.setData(from: game) { error in
                if let error = error {
                    print("Error saving game: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Error encoding game: \(error.localizedDescription)")
        }
    }

    deinit {
        stopMatchTimer()
    }
}