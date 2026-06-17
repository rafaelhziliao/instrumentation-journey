import SwiftUI

struct ChapterCard: View {
    let chapter: ChapterMetadata
    let onTap: () -> Void

    var body: some View {
        Button(action: { if chapter.status != .comingSoon { onTap() } }) {
            cardContent
        }
        .buttonStyle(.plain)
        .disabled(chapter.status == .comingSoon)
    }

    private var cardContent: some View {
        HStack(alignment: .top, spacing: 16) {
            numberBadge
            VStack(alignment: .leading, spacing: 6) {
                titleRow
                Text(chapter.description)
                    .font(.prose(13))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(3)
                    .multilineTextAlignment(.leading)
                achievementRow
            }
            Spacer()
            chevron
        }
        .padding(20)
        .background(AppColors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(borderColor, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .opacity(chapter.status == .comingSoon ? 0.5 : 1)
    }

    private var numberBadge: some View {
        Text(String(format: "%02d", chapter.number))
            .font(.mono(18, weight: .bold))
            .foregroundStyle(accentColor)
            .frame(width: 36)
    }

    private var titleRow: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Text(chapter.title)
                .font(.mono(15, weight: .semibold))
                .foregroundStyle(AppColors.textPrimary)
            statusBadge
        }
    }

    private var statusBadge: some View {
        Group {
            switch chapter.status {
            case .completed:
                Text("DONE")
                    .font(.mono(9, weight: .bold))
                    .foregroundStyle(AppColors.accent)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(AppColors.accent.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 3))
            case .comingSoon:
                Text("SOON")
                    .font(.mono(9, weight: .bold))
                    .foregroundStyle(AppColors.comingSoon)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(AppColors.comingSoon.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 3))
            case .available:
                EmptyView()
            }
        }
    }

    private var achievementRow: some View {
        HStack(spacing: 6) {
            Text(chapter.status == .completed ? chapter.achievementEmoji : "🔒")
                .font(.system(size: 12))
            Text(chapter.achievementTitle)
                .font(.mono(11))
                .foregroundStyle(chapter.status == .completed ? AppColors.accent : AppColors.locked)
        }
        .padding(.top, 2)
    }

    private var chevron: some View {
        Group {
            if chapter.status != .comingSoon {
                Image(systemName: chapter.status == .completed ? "checkmark.circle.fill" : "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(chapter.status == .completed ? AppColors.accent : AppColors.textMuted)
            }
        }
    }

    private var borderColor: Color {
        switch chapter.status {
        case .completed: AppColors.accent.opacity(0.3)
        case .comingSoon: AppColors.border
        case .available: AppColors.border
        }
    }

    private var accentColor: Color {
        switch chapter.status {
        case .completed: AppColors.accent
        case .comingSoon: AppColors.locked
        case .available: AppColors.secondary
        }
    }
}
