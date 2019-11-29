import Combine
import SwiftUI
import UIKit

class KeyboardObserver: ObservableObject {
    struct KeyboardProperty {
        let height: CGFloat
        let duration: Double

        static var none: Self { .init(height: 0, duration: 0) }
    }

    @Published var dockedKeyboardProperty = KeyboardProperty.none

    private var willChangeFrame: AnyCancellable?

    init() {
        willChangeFrame = NotificationCenter.Publisher(center: .default, name: UIResponder.keyboardWillChangeFrameNotification)
            .map {
                guard let userInfo = $0.userInfo,
                    let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
                    let rect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                        return .none
                }

                if rect.maxY == UIScreen.main.bounds.height {
                    return .init(height: rect.height, duration: duration)
                } else {
                    return .init(height: 0, duration: duration)
                }
        }
        .assign(to: \.dockedKeyboardProperty, on: self)
    }

    deinit {
        willChangeFrame?.cancel()
    }
}

struct KeyboardSpacer: View {
    @EnvironmentObject var keyboardObserver: KeyboardObserver

    var body: some View {
        Spacer()
            .frame(height: keyboardObserver.dockedKeyboardProperty.height)
            .animation(.easeOut(duration: keyboardObserver.dockedKeyboardProperty.duration))
    }
}
