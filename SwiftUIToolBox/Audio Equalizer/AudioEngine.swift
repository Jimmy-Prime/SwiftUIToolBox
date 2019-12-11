import AVFoundation

// fade.mp3 is extracted from https://www.youtube.com/watch?v=bM7SZ5SBzyY
// NoCopyrightSounds Alan Walker - Fade

struct EQParam {
    let frequency: Float
    var gain: Float
}

class AudioEngine: ObservableObject {
    let engine = AVAudioEngine()
    let player = AVAudioPlayerNode()
    lazy var eq: AVAudioUnitEQ = { .init(numberOfBands: params.count) }()

    @Published var params: [EQParam] = [
        .init(frequency: 32, gain: 0),
        .init(frequency: 64, gain: 0),
        .init(frequency: 125, gain: 0),
        .init(frequency: 250, gain: 0),
        .init(frequency: 500, gain: 0),
        .init(frequency: 1000, gain: 0),
        .init(frequency: 2000, gain: 0),
        .init(frequency: 4000, gain: 0),
        .init(frequency: 8000, gain: 0),
        .init(frequency: 16000, gain: 0)
    ] {
        didSet {
            configureEQ()
        }
    }

    @Published var isPlaying: Bool = false

    func playPause() {
        if !engine.isRunning {
            try? startEngine()
        } else if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }

    private func startEngine() throws {
        configureEQ()

        let path = Bundle.main.path(forResource: "fade", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        let file = try AVAudioFile(forReading: url)

        let buffer = AVAudioPCMBuffer(
            pcmFormat: file.processingFormat,
            frameCapacity: AVAudioFrameCount(file.length)
        )!

        try file.read(into: buffer)

        engine.attach(player)
        engine.attach(eq)
        engine.connect(player, to: eq, format: buffer.format)
        engine.connect(eq, to: engine.mainMixerNode, format: nil)
        try engine.start()

        player.volume = 0.2

        player.play()
        player.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)

        isPlaying = true
    }

    private func configureEQ() {
        for (index, band) in eq.bands.enumerated() {
            band.frequency = params[index].frequency
            band.gain = params[index].gain
            band.bandwidth = 1
            band.bypass = false
        }
    }
}
