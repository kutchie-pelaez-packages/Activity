import UIKit

public enum ActivityItem {
    case image(UIImage)
    case text(String)
    case file(URL)

    public init(_ image: UIImage) {
        self = .image(image)
    }

    public init(_ string: String) {
        self = .text(string)
    }

    public init(_ url: URL) {
        self = .file(url)
    }
}
