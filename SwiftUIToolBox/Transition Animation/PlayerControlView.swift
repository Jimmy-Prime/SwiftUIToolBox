import SwiftUI

struct PlayerControlView: View {
    var body: some View {
        HStack {
            Image(systemName: "shuffle")
            Spacer()
            Image(systemName: "backward.fill")
            Spacer()
            Image(systemName: "forward.fill")
            Spacer()
            Image(systemName: "repeat")
        }
            .padding()
    }
}
