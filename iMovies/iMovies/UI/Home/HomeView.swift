import SwiftUI
import Networking

struct HomeView: View {
    @State var viewModel: HomeViewModel

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
        }
    }
}

// TODO: Previews should use mock data instead of real data from API
#Preview {
    AppDependency().homeDependencyContainer.makeHomeView()
}
