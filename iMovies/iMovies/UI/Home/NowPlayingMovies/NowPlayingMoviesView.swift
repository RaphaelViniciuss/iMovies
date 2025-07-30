import SwiftUI

struct NowPlayingMoviesView: View {
    @State var viewModel: NowPlayingMoviesViewModel
    @State private var timer: Timer?
    let onSelectMovie: (Int) -> Void

    var body: some View {
        VStack(spacing: 16) {
            TabView(selection: $viewModel.currentPage) {
                ForEach(Array(viewModel.nowPlayingMovies.enumerated()), id: \.offset) { index, movie in
                    card(movie)
                        .tag(index)
                        .onTapGesture {
                            onSelectMovie(movie.id)
                        }

                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 200)

            indicator()
        }
        .onAppear {
            startAutoDrag()
        }
        .onDisappear {
            stopAutoDrag()
        }
        .onChange(of: viewModel.currentPage) { _, _ in
            restartAutoDragTimer()
        }
        .task {
            if viewModel.nowPlayingMovies.isEmpty {
                await viewModel.load()
            }
        }
    }

    @ViewBuilder private func card(_ movie: NowPlayingMovie) -> some View {
        ZStack {
            AsyncImage(url: movie.backdropUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .transition(.opacity.combined(with: .scale))
                    .animation(.easeInOut(duration: 0.4), value: image)
            } placeholder: {
                RoundedRectangle(cornerRadius: 32)
                    .fill(.gray.opacity(0.3))
            }
            .clipShape(RoundedRectangle(cornerRadius: 32))


            LinearGradient(
                gradient: Gradient(colors: [.primaryStyle, .clear]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .cornerRadius(32)

            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .accessibilityIdentifier("MovieCard_\(movie.title)")

                    Text(movie.overview)
                        .font(.callout)
                        .foregroundColor(.secondaryStyle)
                        .lineLimit(4)
                }
                .frame(maxWidth: 200)
                Spacer()
            }
            .padding(16)
        }
        .padding(.horizontal)
    }

    @ViewBuilder private func indicator() -> some View {
        HStack(spacing: 8) {
            ForEach(0..<viewModel.nowPlayingMovies.count, id: \.self) { index in
                Capsule()
                    .fill(index == viewModel.currentPage ? .primaryStyle : .gray.opacity(0.4))
                    .frame(width: index == viewModel.currentPage ? 20 : 8, height: 8)
                    .animation(.easeInOut(duration: 0.3), value: viewModel.currentPage)
            }
        }
    }

    private func startAutoDrag() {
        if timer != nil { stopAutoDrag() }
        timer = Timer.scheduledTimer(withTimeInterval: viewModel.autoDragInterval, repeats: true) { _ in
            guard !viewModel.nowPlayingMovies.isEmpty else { return }
            withAnimation(.easeInOut) {
                viewModel.currentPage = (viewModel.currentPage + 1) % viewModel.nowPlayingMovies.count
            }
        }
        RunLoop.main.add(timer!, forMode: .common)
    }

    private func stopAutoDrag() {
        timer?.invalidate()
        timer = nil
    }

    private func restartAutoDragTimer() {
        stopAutoDrag()
        startAutoDrag()
    }
}

#Preview {
    let viewModel = AppDependency().homeDependencyContainer.makeNowPlayingMoviesViewModel()
    NowPlayingMoviesView(viewModel: viewModel) { id in
        print("Tapped: \(id)")
    }
}
