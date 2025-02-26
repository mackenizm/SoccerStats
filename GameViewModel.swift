import FirebaseFirestore
import Combine

class GameViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published var errorMessage: String? = nil
    private var listener: ListenerRegistration?

    func fetchGames(for userID: String) {
        listener?.remove()
        listener = Firestore.firestore()
            .collection("users")
            .document(userID)
            .collection("games")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch games: \(error.localizedDescription)"
                    return
                }
                self.games = snapshot?.documents.compactMap { try? $0.data(as: Game.self) } ?? []
            }
    }

    func addGame(_ game: Game, for userID: String) {
        do {
            _ = try Firestore.firestore()
                .collection("users")
                .document(userID)
                .collection("games")
                .addDocument(from: game) { error in
                    if let error = error {
                        self.errorMessage = "Failed to add game: \(error.localizedDescription)"
                    }
                }
        } catch {
            self.errorMessage = "Error encoding game: \(error.localizedDescription)"
        }
    }

    deinit {
        listener?.remove()
    }
}