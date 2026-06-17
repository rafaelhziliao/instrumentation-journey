import Foundation
import Combine

final class ProgressRepository: ObservableObject {
    private let defaults = UserDefaults.standard
    private let key = "ij_completed_chapter_ids"

    @Published private(set) var completedIds: Set<String> = []

    init() {
        completedIds = Set(defaults.stringArray(forKey: key) ?? [])
    }

    func isCompleted(_ chapterId: String) -> Bool {
        completedIds.contains(chapterId)
    }

    func markCompleted(_ chapterId: String) {
        completedIds.insert(chapterId)
        defaults.set(Array(completedIds), forKey: key)
    }
}
