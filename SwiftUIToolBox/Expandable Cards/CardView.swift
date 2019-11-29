import SwiftUI

struct CardView: View {
    let content: CardContent

    @State var expand: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(content.title)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(content.description)
                        .font(.body)
                }
                    .padding()

                if expand {
                    Spacer()
                }
            }
                .background(Color(.secondarySystemFill))
                .cornerRadius(16)

            if expand {
                ScrollView {
                    Text(content.content)
                        .padding()
                }
            }
        }
            .clipped()
            .gesture(
                TapGesture()
                    .onEnded {
                        withAnimation {
                            self.expand.toggle()
                        }
                }
            )
            .navigationBarTitle(Text("Expandable Cards"), displayMode: .inline)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(content: .demo)
    }
}
