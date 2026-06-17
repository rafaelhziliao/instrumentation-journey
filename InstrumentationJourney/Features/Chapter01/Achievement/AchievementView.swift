import SwiftUI

struct AchievementView: View {
    let chapter: ChapterMetadata
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            badge
            Spacer()
            doneButton
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(AppColors.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var badge: some View {
        VStack(spacing: 32) {
            Text(chapter.achievementEmoji)
                .font(.system(size: 72))
                .shadow(color: AppColors.accent.opacity(0.4), radius: 24)

            VStack(spacing: 12) {
                Text("ACHIEVEMENT UNLOCKED")
                    .font(.mono(11, weight: .semibold))
                    .foregroundStyle(AppColors.textMuted)
                    .tracking(2)

                Text(chapter.achievementTitle)
                    .font(.mono(24, weight: .bold))
                    .foregroundStyle(AppColors.accent)

                Text("Chapter \(chapter.number) Complete")
                    .font(.mono(14))
                    .foregroundStyle(AppColors.textSecondary)
            }

            divider

            VStack(spacing: 6) {
                Text("You observed before you modified.")
                    .font(.prose(14, weight: .medium))
                    .foregroundStyle(AppColors.textPrimary)
                Text("That is the foundation.")
                    .font(.prose(14))
                    .foregroundStyle(AppColors.textSecondary)
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
        }
    }

    private var divider: some View {
        HStack(spacing: 8) {
            Rectangle().fill(AppColors.border).frame(height: 1)
            Text("✦")
                .font(.system(size: 10))
                .foregroundStyle(AppColors.accent.opacity(0.6))
            Rectangle().fill(AppColors.border).frame(height: 1)
        }
        .padding(.horizontal, 40)
    }

    private var doneButton: some View {
        Button(action: onDone) {
            Text("BACK TO JOURNEY")
                .font(.mono(14, weight: .bold))
                .foregroundStyle(AppColors.background)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(AppColors.accent)
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }
}
