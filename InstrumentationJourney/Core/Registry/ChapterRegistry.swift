/// Single source of truth for all chapter metadata.
/// Add new chapters here as they are announced. Change status from .comingSoon
/// to .available when the chapter and its challenge screen are ready.
enum ChapterRegistry {

    static let catalog: [ChapterMetadata] = [

        ChapterMetadata(
            id: "chapter_01",
            number: 1,
            title: "The Observer",
            description: "What is a process? What is a debugger? What is runtime memory? Find a hidden unlock code without source code.",
            achievementEmoji: "🏆",
            achievementTitle: "Process Observer",
            appVersion: "1.0",
            status: .available
        ),

        ChapterMetadata(
            id: "chapter_02",
            number: 2,
            title: "The Messenger",
            description: "A button with no label triggers an action that leaves no log output. Identify the method and the class using only LLDB and the ObjC runtime.",
            achievementEmoji: "🏆",
            achievementTitle: "Message Intercepted",
            appVersion: "1.1",
            status: .comingSoon
        ),

        ChapterMetadata(
            id: "chapter_03",
            number: 3,
            title: "The Interceptor",
            description: "The app enforces a five-minute cooldown. Bypass it by swapping the implementation of the method that reads elapsed time, without modifying the binary.",
            achievementEmoji: "🏆",
            achievementTitle: "Method Swizzler",
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
