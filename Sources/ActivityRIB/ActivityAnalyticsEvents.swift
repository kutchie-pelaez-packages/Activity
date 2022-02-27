import AnalyticsEvent

extension AnalyticsEvent {
    static func activityPerform(
        activity: String,
        successfully: Bool,
        items: [ActivityItem]
    ) -> AnalyticsEvent {
        AnalyticsEvent(
            domain: .activity,
            action: .perform,
            parameters: [
                "activity": activity,
                "successfully": successfully,
                "items": items.analyticsName
            ]
        )
    }
}

extension AnalyticsDomain {
    fileprivate static let activity: Self = "activity"
}

extension ActivityItem {
    fileprivate var analyticsName: String {
        switch self {
        case .image:
            return "image"

        case .text:
            return "text"

        case .file:
            return "file"
        }
    }
}

extension Array where Element == ActivityItem {
    fileprivate var analyticsName: String? {
        var itemNameToCount = [String: Int]()

        for itemName in map(\.analyticsName) {
            let count = itemNameToCount[itemName] ?? 0
            itemNameToCount[itemName] = count + 1
        }

        guard itemNameToCount.isNotEmpty else { return nil }

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
