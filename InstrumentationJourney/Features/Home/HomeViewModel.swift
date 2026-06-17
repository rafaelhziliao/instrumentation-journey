import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var chapters: [ChapterMetadata] = []

    private let repository: ProgressRepository
    private var cancellables = Set<AnyCancellable>()

    init(repository: ProgressRepository) {
        self.repository = repository
        // Re-resolve chapters whenever saved progress changes.
        repository.$completedIds
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.resolve() }
            .store(in: &cancellables)
        resolve()
    }

    var completedCount: Int { chapters.filter { $0.status == .completed }.count }
    var totalCount: Int { chapters.filter { $0.status != .comingSoon }.count }
    var progress: Double {
        totalCount > 0 ? Double(completedCount) / Double(totalCount) : 0
    }

    private func resolve() {
        chapters = ChapterRegistry.resolved(using: repository)
    }
}
