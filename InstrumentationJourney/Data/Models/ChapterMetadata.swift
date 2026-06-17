struct ChapterMetadata: Identifiable, Hashable {
    let id: String
    let number: Int
    let title: String
    let description: String
    let achievementEmoji: String
    let achievementTitle: String
    let appVersion: String
    var status: ChapterStatus

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: ChapterMetadata, rhs: ChapterMetadata) -> Bool { lhs.id == rhs.id }
}
