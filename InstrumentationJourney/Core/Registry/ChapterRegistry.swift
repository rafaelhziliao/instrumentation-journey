/// Single source of truth for all chapter metadata.
/// Add new chapters here as they are released — change status from .comingSoon to .available
/// and update the corresponding challenge screen.
enum ChapterRegistry {

    static let catalog: [ChapterMetadata] = [

        ChapterMetadata(
            id: "chapter_01",
            number: 1,
            title: "The Observer",
            description: "What is a process? What is a debugger? What is runtime memory? Find a hidden unlock code — without source code.",
            achievementEmoji: "🏆",
            achievementTitle: "Process Observer",
            appVersion: "1.0",
            status: .available
        ),

        ChapterMetadata(
            id: "chapter_02",
            number: 2,
            title: "The Messenger",
            description: "A button with no label triggers an action that leaves no log output. Identify the method and the class — using only LLDB and the ObjC runtime.",
            achievementEmoji: "🏆",
            achievementTitle: "Message Intercepted",
            appVersion: "1.1",
            status: .comingSoon
        ),

        ChapterMetadata(
            id: "chapter_03",
            number: 3,
            title: "The Interceptor",
            description: "The app enforces a five-minute cooldown. Bypass it by swapping the implementation of the method that reads elapsed time — without modifying the binary.",
            achievementEmoji: "🏆",
            achievementTitle: "Method Swizzler",
            appVersion: "1.2",
            status: .comingSoon
        ),

        ChapterMetadata(
            id: "chapter_04",
            number: 4,
            title: "The Linker",
            description: "The app calls a C function that influences its behavior. Identify it by watching dyld resolve the symbol on first call — before any hook is in place.",
            achievementEmoji: "🏆",
            achievementTitle: "Symbol Resolver",
            appVersion: "1.3",
            status: .comingSoon
        ),

        ChapterMetadata(
            id: "chapter_05",
            number: 5,
            title: "The Import Rewriter",
            description: "arc4random_uniform generates a validation code that changes on every launch. Hook it to always return a known value — using fishhook.",
            achievementEmoji: "🏆",
            achievementTitle: "Import Rewriter",
            appVersion: "1.4",
            status: .comingSoon
        ),

        ChapterMetadata(
            id: "chapter_06",
            number: 6,
            title: "The Inline Hook",
            description: "An internal Swift validation function — not ObjC, not imported. Swizzling won't reach it. fishhook won't reach it. Hook it at the machine code level using Dobby.",
            achievementEmoji: "🏆",
            achievementTitle: "Inline Hooker",
            appVersion: "1.5",
            status: .comingSoon
        ),

        ChapterMetadata(
            id: "chapter_07",
            number: 7,
            title: "The Toolkit",
            description: "Three protections fire simultaneously. Write a single Frida script that bypasses all of them in one run — no recompilation, no binary modification.",
            achievementEmoji: "🏆",
            achievementTitle: "Dynamic Explorer",
            appVersion: "1.6",
            status: .comingSoon
        ),

        ChapterMetadata(
            id: "chapter_08",
            number: 8,
            title: "The Real Target",
            description: "A real binary with ptrace(PT_DENY_ATTACH). No source code. No entitlement changes. Choose your approach — every technique from the previous chapters applies.",
            achievementEmoji: "🏆",
            achievementTitle: "Journey Complete",
            appVersion: "2.0",
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
