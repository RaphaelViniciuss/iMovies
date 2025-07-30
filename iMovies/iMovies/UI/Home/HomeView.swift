import SwiftUI
import Networking

struct HomeView: View {
    @State var viewModel: HomeViewModel

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            ScrollView(.vertical) {
                VStack(spacing: 24) {
                    nowPlayingContent()
                    Spacer()
                }
            }
            .padding(.top, 16)
        }
    }

    @ViewBuilder private func nowPlayingContent() -> some View {
        NowPlayingMoviesView(viewModel: viewModel.nowPlayingViewModel) { id in
            viewModel.onNavigate(.movieDetail(id))
        }
    }
        }
    }
}

// TODO: Previews should use mock data instead of real data from API
#Preview {
    AppDependency().homeDependencyContainer.makeHomeView()
}
