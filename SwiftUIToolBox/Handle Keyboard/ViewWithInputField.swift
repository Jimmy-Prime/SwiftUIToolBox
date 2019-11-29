import SwiftUI

struct ViewWithInputField: View {
    var body: some View {
        VStack {
            List(0..<30) { index in
                Text("Content \(index)")
            }
            InputView()
                .padding([.leading, .trailing])
            KeyboardSpacer()
        }
            .navigationBarTitle(Text("Handle Keyboard"), displayMode: .inline)
    }
}

private struct InputView: View {
    @State var text = ""

    var body: some View {
        HStack {
            TextField("Type something", text: $text)
            Button(action: send) {
                Text("send")
            }
                .disabled(text.isEmpty)
        }
    }

    func send() {
        print("send: \(text)")
    }
}

struct ViewWithInputField_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ViewWithInputField()
                .environmentObject(KeyboardObserver())
        }
    }
}
