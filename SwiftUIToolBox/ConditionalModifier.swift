import SwiftUI

// https://swiftui-lab.com/view-extensions-for-better-code-readability/
// modified from this

extension View {
    func condition<M: ViewModifier>(_ condition: Bool, then modifier: M) -> some View {
        Group {
            if condition {
                self.modifier(modifier)
            } else {
                self
            }
        }
    }

    func condition<M1: ViewModifier, M2: ViewModifier>(_ condition: Bool, true modifierTrue: M1, false modifierFalse: M2) -> some View {
        Group {
            if condition {
                self.modifier(modifierTrue)
            } else {
                self.modifier(modifierFalse)
            }
        }
    }
}
