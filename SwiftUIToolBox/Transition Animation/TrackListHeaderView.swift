import SwiftUI

struct TrackListHeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Playlist name")
                    .font(.headline)
                Text("Playlist description")
                    .font(.footnote)
            }
            Spacer()
            Image(systemName: "command")
        }
            .padding()
    }
}
