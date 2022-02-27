import ActivityRIB
import AnalyticsTracker
import CoreRIB
import Logger
import UIKit

public final class ActivityComp {
    public init(
        logger: Logger,
        analyticsTracker: AnalyticsTracker
    ) {
        self.logger = logger
        self.analyticsTracker = analyticsTracker
    }

    let logger: Logger
    let analyticsTracker: AnalyticsTracker

    // MARK: - Public

    public var activityFactory: ScopedRouterFactory<ActivityArgs> {
        ActivityFactory().scoped { [unowned self] args in
            ActivityDependenciesImpl(
                parent: self,
                items: args.items,
                source: args.source,
                trackToAnalytics: args.trackToAnalytics,
                delegate: args.delegate
            )
        }
    }
}
