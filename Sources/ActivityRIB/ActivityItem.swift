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

    var name: String {
        switch self {
        case .image: return "image"
        case .text: return "text"
        case .file: return "file"
        }
    }
}

extension Array where Element == ActivityItem {
    var name: String {
        var itemNameToCount = [String: Int]()

        for itemName in map(\.name) {
            let count = itemNameToCount[itemName] ?? 0
            itemNameToCount[itemName] = count + 1
        }

        let items = itemNameToCount.keys
            .map { String($0) }
            .sorted()

        return items
            .map { item in
                let count = itemNameToCount[item]!

                return count > 1 ? "\(count) \(item)s" : item
            }
            .joined(separator: ", ")
    }
}
