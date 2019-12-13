import SwiftUI

struct ChatInputView: View {
    @State var text: String = ""
    @State var showPhotos = false

    var body: some View {
        VStack {
            HStack {
                Button(action: { withAnimation { self.showPhotos.toggle() } }) {
                    Image(systemName: showPhotos ? "camera.fill" : "camera")
                }

                TextField("OAO", text: $text)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(.infinity)

                Button(action: sendText) {
                    Text("send")
                }
                .disabled(text.isEmpty)
            }

            if showPhotos {
                PhotoPanel()
            }
        }
    }

    func sendText() {
        print("send: \(text)")
        text = ""
    }
}

#if DEBUG
struct ChatInputView_Previews: PreviewProvider {
    static var previews: some View {
        ChatInputView()
    }
}
#endif
