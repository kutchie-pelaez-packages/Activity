import AnalyticsEvent

extension AnalyticsEvent {
    static func activityPerform(
        activity: Activity,
        successfully: Bool,
        items: [ActivityItem]
    ) -> AnalyticsEvent {
        AnalyticsEvent(
            domain: .activity,
            action: .perform,
            parameters: [
                "activity": activity.name,
                "successfully": successfully,
                "items": items.name
            ]
        )
    }
}

extension AnalyticsDomain {
    fileprivate static let activity: Self = "activity"
}
