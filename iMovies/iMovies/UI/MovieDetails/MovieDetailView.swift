import SwiftUI

struct MovieDetailView: View {
    @State var viewModel: MovieDetailViewModel
    @State private var isExpanded = false
    let onBackPressed: () -> Void

    var body: some View {
        ZStack {
            topBar
                .zIndex(99)

            backdrop
                .zIndex(0)

            Rectangle()
                .fill(.black.opacity(0.45))
                .ignoresSafeArea()
                .zIndex(1)

            if let movie = viewModel.movie {
                ScrollView {
                    VStack(spacing: 16) {
                        poster(movie)
                        headerInfo(movie)

                        VStack(spacing: 24) {
                            overview(movie)
                            cast(movie)
                        }
                    }
                    .padding(.top, 40)
                }
                .frame(maxWidth: .infinity)
                .zIndex(2)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await viewModel.load()
        }
    }

    private var backdrop: some View {
        GeometryReader { proxy in
            AsyncImage(url: viewModel.movie?.poster) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width)
                    .blur(radius: 30)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.4), value: image)
            } placeholder: {
                Rectangle().fill(.gray.opacity(0.3))
            }
            .ignoresSafeArea()
        }
    }

    private var topBar: some View {
        VStack {
            HStack {
                Button {
                    onBackPressed()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .padding(10)
                        .background(.thinMaterial, in: Circle())
                        .shadow(radius: 5)
                }
                Spacer()
            }
            .padding(.horizontal)
            Spacer()
        }
    }

    @ViewBuilder private func poster(_ movie: Movie) -> some View {
        AsyncImage(url: movie.poster) { image in
            image
                .resizable()
                .scaledToFit()
                .shadow(radius: 10)
                .transition(.opacity.combined(with: .scale))
                .animation(.easeInOut(duration: 0.4), value: movie.id)
        } placeholder: {
            Rectangle().fill(Color.gray.opacity(0.3))
        }
        .frame(width: 220, height: 320)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    @ViewBuilder private func headerInfo(_ movie: Movie) -> some View {
        // TITLE
        Text(movie.title)
            .font(.title2.bold())
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .accessibilityIdentifier("MovieDetail_\(movie.title)")

        // INFO ROW
        HStack(spacing: 16) {
            Label(
                Calendar.current.component(.year, from: movie.releaseDate).description,
                systemImage: "calendar"
            )
            Label("\(movie.runtime) mins", systemImage: "clock")
            Label(movie.genre, systemImage: "film")
        }
        .font(.subheadline)
        .foregroundStyle(.white.opacity(0.8))

        // RATING
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
            Text("\(movie.voteAverage, specifier: "%.1f")")
                .font(.subheadline.bold())
                .foregroundStyle(.white)
        }
    }

    @ViewBuilder private func overview(_ movie: Movie) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Story Line")
                .font(.title3.bold())
                .foregroundStyle(.white)

            Text(movie.overview)
                .font(.callout)
                .foregroundStyle(.white.opacity(0.9))
                .lineLimit(isExpanded ? nil : 4)

            Button(action: {
                withAnimation(.easeInOut) { isExpanded.toggle() }
            }) {
                Text(isExpanded ? "Less" : "More")
                    .font(.footnote)
                    .foregroundStyle(.cyan)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
    }

    @ViewBuilder private func cast(_ movie: Movie) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Cast and Crew")
                .font(.title3.bold())
                .foregroundStyle(.white)
                .padding(.horizontal, 24)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(movie.cast) { person in
                        VStack(spacing: 6) {
                            AsyncImage(url: person.profilePicture) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())

                            Text(person.name)
                                .font(.caption)
                                .foregroundStyle(.white)
                                .lineLimit(2)

                            Text(person.character)
                                .font(.caption2)
                                .foregroundStyle(.white.opacity(0.7))
                                .lineLimit(2)
                        }
                        .frame(width: 60)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
    }
}

#Preview {
    let viewModel = AppDependency().movieDetailsDependencyContainer.makeMovieDetailsViewModel(552524)
    MovieDetailView(viewModel: viewModel) {
        print("Back pressed")
    }
}
