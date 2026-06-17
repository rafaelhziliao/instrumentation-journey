/// Contract every chapter challenge must fulfill.
protocol Challenge {
    var chapterId: String { get }
    func verify(_ input: String) -> Bool
}
