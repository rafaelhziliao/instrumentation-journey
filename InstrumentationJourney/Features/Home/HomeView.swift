import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @State private var navigationPath = NavigationPath()

    init(repository: ProgressRepository) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(repository: repository))
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    header
                    Divider()
                        .background(AppColors.border)
                        .padding(.vertical, 28)
                    chaptersSection
                    footer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
            }
            .background(AppColors.background.ignoresSafeArea())
            .navigationTitle("Instrumentation Journey")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(AppColors.surface, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationDestination(for: AppRoute.self, destination: routeDestination)
        }
    }

    // MARK: - Subviews

    private var header: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Instrumentation\nJourney")
                .font(.mono(34, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)
                .lineSpacing(4)
            progressSection
        }
    }

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                TerminalLabel(text: "// PROGRESS")
                Spacer()
                Text("\(viewModel.completedCount) / \(viewModel.totalCount) chapters")
                    .font(.mono(12))
                    .foregroundStyle(AppColors.textSecondary)
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(AppColors.border).frame(height: 3)
                    Capsule()
                        .fill(AppColors.accent)
                        .frame(width: geo.size.width * viewModel.progress, height: 3)
                        .animation(.easeInOut(duration: 0.4), value: viewModel.progress)
                }
            }
            .frame(height: 3)
        }
    }

    private var chaptersSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            TerminalLabel(text: "// CHAPTERS")
            ForEach(viewModel.chapters) { chapter in
                ChapterCard(chapter: chapter) {
                    navigate(to: chapter)
                }
            }
        }
    }

    private var footer: some View {
        Text("iOS instrumentation • runtime analysis\nreverse engineering • mobile security")
            .font(.mono(10))
            .foregroundStyle(AppColors.textMuted)
            .padding(.top, 32)
            .padding(.bottom, 8)
    }

    // MARK: - Navigation

    @ViewBuilder
    private func routeDestination(_ route: AppRoute) -> some View {
        switch route {
        case .chapter01Challenge(let chapter):
            Chapter01ChallengeView(chapter: chapter) {
                navigationPath.append(AppRoute.chapter01Achievement(chapter))
            }
        case .chapter01Achievement(let chapter):
            AchievementView(chapter: chapter) {
                navigationPath.removeLast(navigationPath.count)
            }
        }
    }

    private func navigate(to chapter: ChapterMetadata) {
        switch chapter.id {
        case "chapter_01": navigationPath.append(AppRoute.chapter01Challenge(chapter))
        default: break
        }
    }
}

// MARK: - App Navigation Routes

enum AppRoute: Hashable {
    case chapter01Challenge(ChapterMetadata)
    case chapter01Achievement(ChapterMetadata)
}
