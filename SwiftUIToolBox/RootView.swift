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
