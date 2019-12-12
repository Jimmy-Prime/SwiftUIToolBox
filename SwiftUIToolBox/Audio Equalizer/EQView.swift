import SwiftUI

struct EQBarView: View {
    @Binding var param: EQParam

    var body: some View {
        HStack {
            Text(frequencyString)
                .frame(width: 40)
            Slider(value: $param.gain, in: -10...10, step: 1)
            Text(String(Int(param.gain)))
                .frame(width: 30)
        }
    }

    var frequencyString: String {
        if param.frequency < 1000 {
            return String(Int(param.frequency))
        } else {
            return "\(Int(param.frequency / 1000))k"
        }
    }
}

struct EQView: View {
    @EnvironmentObject var engine: AudioEngine

    var body: some View {
        List {
            ForEach(0..<engine.params.count) { index in
                EQBarView(param: self.$engine.params[index])
            }

            Button(action: engine.playPause) {
                Image(systemName: engine.isPlaying ? "pause.fill" : "play.fill")
            }
        }
    }
}

struct EQView_Previews: PreviewProvider {
    static var previews: some View {
        EQView()
            .environmentObject(AudioEngine())
    }
}
