import SwiftUI

struct TrackView: View {
    let track: Track

    var body: some View {
        HStack {
            Image(track.album)
                .resizable()
                .frame(width: 44, height: 44)
            VStack(alignment: .leading) {
                Text(track.name)
                    .font(.headline)
                Text(track.artist)
                    .font(.footnote)
            }
            Spacer()
            Text("3:45")
        }
            .padding()
    }
}
