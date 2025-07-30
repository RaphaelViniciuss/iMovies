import SwiftUI

struct PopularMoviesView: View {
    @State var viewModel: PopularMoviesViewModel
    let onSelectMovie: (Int) -> Void

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Popular movies")
                    .font(.title2.bold())
                    .foregroundStyle(.lineDark)
                Spacer()

                Button("See All") { }
                    .font(.callout)
                    .foregroundColor(.headlineButton)
            }
            .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.popularMovies) { movie in
                        Button {
                            onSelectMovie(movie.id)
                        } label: {
                            movieCard(movie)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .task {
            if viewModel.popularMovies.isEmpty {
                await viewModel.load()
            }
        }
    }

    @ViewBuilder private func movieCard(_ movie: PopularMovie) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: movie.poster) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .transition(.opacity.combined(with: .scale))
                    .animation(.easeInOut(duration: 0.4), value: movie.id)
            } placeholder: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.gray.opacity(0.3))
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    )
            }
            .frame(width: 140, height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.subheadline.bold())
                    .foregroundColor(.tertiary)
                    .lineLimit(1)

                Text(movie.genres.joined(separator: ", "))
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
        }
        .frame(width: 140)
    }
}

#Preview {
    PopularMoviesView(
        viewModel: AppDependency().homeDependencyContainer.makePopularMoviesViewModel()
    ) { id in
        print("On click:: \(id)")
    }
}
