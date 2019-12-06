import SwiftUI

struct PlayerView: View {
    let tracks: [Track] = load(fileName: "meta", type: "json")!

    @State var isPlaying = false {
        didSet {
            if isPlaying {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    if self.isPlaying {
                        withAnimation(Animation.linear(duration: 4.0).repeatForever(autoreverses: false)) {
                            self.rotate = true
                        }
                    }
                }
            } else {
                rotate = false
            }
        }
    }
    @State var rotate = false

    var body: some View {
        VStack {
            if isPlaying {
                Spacer()

                TrackTitleView()
            }

            ZStack(alignment: isPlaying ? .center : .bottom) {
                Image("One More Light")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(isPlaying ? 150 : 0)
                    .frame(
                        maxWidth: isPlaying ? 300 : .infinity,
                        maxHeight: 300
                )
                    .clipped()
                    .rotationEffect(Angle(degrees: rotate ? 0 : 360))

                HStack {
                    if !isPlaying {
                        TrackTitleView()
                            .foregroundColor(.white)
                        Spacer()
                    }
                    Button(action: toggleIsPlaying) {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    }
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color(.systemRed))
                        .clipShape(Circle())
                }
                    .padding()
            }

            if isPlaying {
                Spacer()

                PlayerControlView()
                    .transition(.move(edge: .bottom))
            } else {
                ScrollView {
                    TrackListHeaderView()

                    ForEach(tracks) { track in
                        TrackView(track: track)
                    }
                }
                    .transition(.move(edge: .bottom))
            }
        }
            .edgesIgnoringSafeArea(.top)
    }

    private func toggleIsPlaying() {
        withAnimation {
            self.isPlaying.toggle()
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
