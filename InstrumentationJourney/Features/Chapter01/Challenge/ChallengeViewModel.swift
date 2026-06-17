import Foundation
import Combine

enum ChallengeState: Equatable {
    case idle
    case error(String)
    case success
}

@MainActor
final class ChallengeViewModel: ObservableObject {
    @Published private(set) var state: ChallengeState = .idle

    let challenge = SecretAssembler()

    init() {
        // Trigger assembly on init so the string is live in memory from launch.
        // This makes LLDB heap scanning reliable without requiring user interaction.
        _ = SecretAssembler.unlockCode
    }

    func submit(_ input: String) {
        guard !input.trimmingCharacters(in: .whitespaces).isEmpty else {
            state = .error("Enter the unlock code.")
            return
        }

        if challenge.verify(input) {
            state = .success
        } else {
            state = .error("Incorrect. Keep observing.")
        }
    }

    func resetError() {
        if case .error = state { state = .idle }
    }
}
