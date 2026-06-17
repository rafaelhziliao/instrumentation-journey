import SwiftUI

struct Chapter01ChallengeView: View {
    let chapter: ChapterMetadata
    let onComplete: () -> Void

    @EnvironmentObject private var repository: ProgressRepository
    @StateObject private var viewModel = ChallengeViewModel()
    @State private var inputText = ""
    @FocusState private var fieldFocused: Bool

    init(chapter: ChapterMetadata, onComplete: @escaping () -> Void) {
        self.chapter = chapter
        self.onComplete = onComplete
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                challengeLabel
                title
                descriptionBlock
                    .padding(.top, 24)
                inputSection
                    .padding(.top, 32)
                hintBlock
                    .padding(.top, 40)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("Chapter 1: The Observer")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppColors.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onChange(of: viewModel.state) { newState in
            if case .success = newState {
                repository.markCompleted(viewModel.challenge.chapterId)
                onComplete()
            }
        }
    }

    // MARK: - Subviews

    private var challengeLabel: some View {
        TerminalLabel(text: "// CHALLENGE")
    }

    private var title: some View {
        Text("The Observer")
            .font(.mono(28, weight: .bold))
            .foregroundStyle(AppColors.accent)
            .padding(.top, 16)
    }

    private var descriptionBlock: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Every modification begins with observation.")
                .font(.prose(15, weight: .medium))
                .foregroundStyle(AppColors.textPrimary)

            Text(
                "This application holds a secret in memory. " +
                "The secret does not exist in any file. " +
                "It is assembled at runtime and lives only in the process heap.\n\n" +
                "Attach a debugger. Inspect the running process. " +
                "Retrieve what it holds."
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.prose(14))
            .foregroundStyle(AppColors.textSecondary)
            .lineSpacing(3)

            VStack(alignment: .leading, spacing: 4) {
                Text("Target: the running iOS process")
                    .font(.mono(13))
                    .foregroundStyle(AppColors.secondary)
                Text("Tool:   LLDB")
                    .font(.mono(13))
                    .foregroundStyle(AppColors.secondary)
            }
            .padding(.top, 4)
        }
        .padding(20)
        .background(AppColors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(AppColors.border, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private var inputSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            TerminalLabel(text: "// UNLOCK CODE")

            TextField("", text: $inputText, prompt:
                Text("ENTER_CODE_HERE")
                    .font(.mono(16))
                    .foregroundColor(AppColors.textMuted)
            )
            .font(.mono(16))
            .foregroundStyle(AppColors.textPrimary)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.characters)
            .focused($fieldFocused)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(AppColors.surfaceElevated)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(inputBorderColor, lineWidth: fieldFocused ? 1.5 : 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .onChange(of: inputText) { _ in viewModel.resetError() }
            .onSubmit { viewModel.submit(inputText) }

            if case .error(let msg) = viewModel.state {
                errorRow(message: msg)
            }

            Button {
                viewModel.submit(inputText)
                fieldFocused = false
            } label: {
                Text("UNLOCK")
                    .font(.mono(14, weight: .bold))
                    .foregroundStyle(AppColors.background)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(AppColors.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .padding(.top, 4)
        }
    }

    private func errorRow(message: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "xmark.circle")
                .font(.system(size: 13))
                .foregroundStyle(AppColors.error)
            Text(message)
                .font(.mono(13))
                .foregroundStyle(AppColors.error)
        }
    }

    private var hintBlock: some View {
        VStack(alignment: .leading, spacing: 10) {
            TerminalLabel(text: "// APPROACH")
            Text("$ lldb")
                .font(.mono(12))
                .foregroundStyle(AppColors.accent)
            Text("$ device list")
                .font(.mono(12))
                .foregroundStyle(AppColors.accent)
            Text("(lldb) device select \"iPhone\"")
                .font(.mono(12))
                .foregroundStyle(AppColors.accent)
            Text("(lldb) device process attach -n InstrumentationJourney --waitfor")
                .font(.mono(12))
                .foregroundStyle(AppColors.accent)
            Text("> Inspect the heap. The answer is already there.")
                .font(.mono(12))
                .foregroundStyle(AppColors.textMuted)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(AppColors.surfaceElevated)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(AppColors.border, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    private var inputBorderColor: Color {
        switch viewModel.state {
        case .error: AppColors.error
        default: fieldFocused ? AppColors.accent : AppColors.border
        }
    }
}
