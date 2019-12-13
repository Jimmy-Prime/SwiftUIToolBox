import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ViewWithInputField().environmentObject(KeyboardObserver())) {
                    Text("Handle Keyboard")
                }
                NavigationLink(destination: CardView(content: .demo)) {
                    Text("Expandable Cards")
                }
                NavigationLink(destination: PlayerView()) {
                    Text("Transition Animation")
                }
                NavigationLink(destination: EQView().environmentObject(AudioEngine())) {
                    Text("Audio Equalizer")
                }
                NavigationLink(destination: ChatInputView()) {
                    Text("Photos and Permission")
                }
            }
                .navigationBarTitle(Text("OAO"))
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
