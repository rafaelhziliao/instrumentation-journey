import SwiftUI

/// Small monospace comment-style label — e.g. "// CHAPTERS"
struct TerminalLabel: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.mono(11, weight: .medium))
            .foregroundStyle(AppColors.textMuted)
    }
}
