import Foundation

struct CardContent: Identifiable {
    let title: String
    let description: String
    let content: String

    var id: String { title }

    static var demo: Self {
        .init(
            title: "Title",
            description: "Description",
            content: "By default, a view's bounding frame only affects its layout, so any content that extends beyond the edges of the frame remains visible. Use the `cornerRadius()` modifier to hide any content that extends beyond these edges while applying a corner radius."
        )
    }
}
