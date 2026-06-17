import SwiftUI

@main
struct InstrumentationJourneyApp: App {
    @StateObject private var repository = ProgressRepository()

    var body: some Scene {
        WindowGroup {
            HomeView(repository: repository)
                .environmentObject(repository)
                .preferredColorScheme(.dark)
        }
    }
}
