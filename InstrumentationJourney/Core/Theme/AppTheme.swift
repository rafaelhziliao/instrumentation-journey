import SwiftUI

// MARK: - Colors

enum AppColors {
    static let background       = Color(hex: "0A0A0F")
    static let surface          = Color(hex: "12121A")
    static let surfaceElevated  = Color(hex: "1A1A26")
    static let border           = Color(hex: "2A2A3A")
    static let accent           = Color(hex: "00FF9C")
    static let secondary        = Color(hex: "4ECDC4")
    static let textPrimary      = Color(hex: "E8E8F0")
    static let textSecondary    = Color(hex: "8888A8")
    static let textMuted        = Color(hex: "55556A")
    static let locked           = Color(hex: "444455")
    static let error            = Color(hex: "FF5555")
    static let comingSoon       = Color(hex: "6B5FCC")
}

extension Color {
    init(hex: String) {
        var int: UInt64 = 0
        Scanner(string: hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
            .scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1)
    }
}

// MARK: - Typography
// Uses SF Mono (monospaced) and SF Pro (default) — zero external dependencies.

extension Font {
    static func mono(_ size: CGFloat, weight: Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .monospaced)
    }

    static func prose(_ size: CGFloat, weight: Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}
