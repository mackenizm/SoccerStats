import FirebaseFirestore
import Combine

class TeamViewModel: ObservableObject {
    @Published var teams: [Team] = []
    @Published var errorMessage: String? = nil
    private var listener: ListenerRegistration?

    func fetchTeams() {
        listener?.remove()
        listener = Firestore.firestore()
            .collection("teams")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch teams: \(error.localizedDescription)"
                    return
                }
                self.teams = snapshot?.documents.compactMap { try? $0.data(as: Team.self) } ?? []
            }
    }

    func addTeam(_ team: Team) {
        do {
            _ = try Firestore.firestore()
                .collection("teams")
                .addDocument(from: team) { error in
                    if let error = error {
                        self.errorMessage = "Failed to add team: \(error.localizedDescription)"
                    }
                }
        } catch {
            self.errorMessage = "Error encoding team: \(error.localizedDescription)"
        }
    }

    deinit {
        listener?.remove()
    }
}