import ActivityRIB
import AnalyticsTracker
import Core
import CoreUI
import Logger
import UIKit

struct ActivityDependenciesImpl: ActivityDependencies {
    unowned let parent: ActivityComp

    // MARK: - Args

    let items: [ActivityItem]

    let source: UIViewController

    let trackToAnalytics: Bool

    let delegate: ActivityDelegate

    // MARK: - Scoped

    var logger: Logger { parent.logger }

    var analyticsTracker: AnalyticsTracker { parent.analyticsTracker }
}
