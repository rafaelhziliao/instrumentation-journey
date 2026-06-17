/// Single source of truth for all chapter metadata.
/// Add new chapters here as they are released. Status is resolved at runtime
/// by merging against the user's saved progress.
enum ChapterRegistry {
    static let catalog: [ChapterMetadata] = [
        ChapterMetadata(
            id: "chapter_01",
            number: 1,
            title: "The Observer",
            description: "Understand a process before modifying it. Observation is the foundation of instrumentation.",
            achievementEmoji: "🏆",
            achievementTitle: "Process Observer",
            appVersion: "1.0",
            status: .available
        ),
        ChapterMetadata(
            id: "chapter_02",
            number: 2,
            title: "Runtime Explorer",
            description: "Explore the Objective-C runtime and understand how method dispatch works under the hood.",
            achievementEmoji: "🏆",
            achievementTitle: "Runtime Explorer",
            appVersion: "1.1",
            status: .comingSoon
        ),
        ChapterMetadata(
            id: "chapter_03",
            number: 3,
            title: "Import Rewriter",
            description: "Redirect function calls at the import table level using fishhook.",
            achievementEmoji: "🏆",
            achievementTitle: "Import Rewriter",
            appVersion: "1.2",
            status: .comingSoon
        ),
    ]

    static func resolved(using repository: ProgressRepository) -> [ChapterMetadata] {
        catalog.map { chapter in
            guard chapter.status != .comingSoon else { return chapter }
            var updated = chapter
            updated.status = repository.isCompleted(chapter.id) ? .completed : .available
            return updated
        }
    }
}
