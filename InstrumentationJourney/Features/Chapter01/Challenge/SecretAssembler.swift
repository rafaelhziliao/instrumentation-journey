/// Implements the Chapter 1 challenge.
///
/// The unlock code is assembled at runtime from XOR-obfuscated byte segments.
/// It never exists as a complete plaintext string in the compiled binary.
///
/// Intended solution: runtime inspection with LLDB.
///   (lldb) device select "iPhone"
///   (lldb) device process attach -n InstrumentationJourney
///   (lldb) image lookup -rn "unlockCode"
///   (lldb) po SecretAssembler.unlockCode
///
/// Static analysis is possible but requires:
///   1. Locating both byte arrays in the binary.
///   2. Identifying the XOR key (not co-located with the arrays).
///   3. Decoding each segment independently and concatenating.
final class SecretAssembler: Challenge {

    // XOR key — stored separately from byte arrays to increase static analysis friction.
    private static var key: UInt8 = 0x42

    // Segment 1: encodes "PROCESS"
    private static let s1: [UInt8] = [0x12, 0x10, 0x0D, 0x01, 0x07, 0x11, 0x11]

    // Segment 2: encodes "_OBSERVER"
    private static let s2: [UInt8] = [0x1D, 0x0D, 0x00, 0x11, 0x07, 0x10, 0x14, 0x07, 0x10]

    // Lazily assembled — the complete string only materialises in heap memory
    // the first time unlockCode is accessed.
    private static var _assembled: String?

    /// Returns the assembled unlock code.
    /// After first access, "PROCESS_OBSERVER" lives as a Swift String on the heap.
    static var unlockCode: String {
        if _assembled == nil {
            let bytes = (s1 + s2).map { $0 ^ key }
            _assembled = String(bytes: bytes, encoding: .ascii)
        }
        return _assembled!
    }

    // MARK: - Challenge

    var chapterId: String { "chapter_01" }

    func verify(_ input: String) -> Bool {
        input.trimmingCharacters(in: .whitespaces).uppercased() == SecretAssembler.unlockCode
    }
}
