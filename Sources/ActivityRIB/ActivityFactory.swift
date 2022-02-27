import AnalyticsTracker
import Core
import CoreRIB
import Logger
import UIKit

public protocol ActivityDependencies {
    var logger: Logger { get }
    var analyticsTracker: AnalyticsTracker { get }
    var items: [ActivityItem] { get }
    var source: UIViewController { get }
    var trackToAnalytics: Bool { get }
    var delegate: ActivityDelegate { get }
}

public struct ActivityArgs {
    public init(
        items: [ActivityItem],
        source: UIViewController,
        trackToAnalytics: Bool = true,
        delegate: ActivityDelegate
    ) {
        self.items = items
        self.source = source
        self.trackToAnalytics = trackToAnalytics
        self.delegate = delegate
    }

    public let items: [ActivityItem]
    public let source: UIViewController
    public let trackToAnalytics: Bool
    public let delegate: ActivityDelegate
}

public protocol ActivityDelegate: AnyObject {
    func activityDidRequestClosing()
}

public struct ActivityFactory: RouterFactory {
    public init() { }

    public func produce(dependencies: ActivityDependencies) -> Routable {
        let viewController = UIActivityViewController(
            activityItems: dependencies.items.map(\.erased),
            applicationActivities: nil
        )

        let logger = dependencies.logger
        let analyticsTracker = dependencies.analyticsTracker

        viewController.completionWithItemsHandler = { [weak delegate = dependencies.delegate] activityType, successfully, items, error in
            let activityId = activityType?.rawValue
            let items = dependencies.items

            guard let activity = Activity(rawValue: activityId ?? "") else {
                logger.error("Failed to construct activity from \(activityId ?? "UNKNOWN")", domain: .activity)
                safeCrash()
                return
            }

            defer { delegate?.activityDidRequestClosing() }

            if let error = error {
                logger.error("Failed to perform \(activity.name) activity with [\(items.name)] items, error: \(error.localizedDescription)", domain: .activity)
                safeCrash()
            } else if activityId.isNotNil {
                if dependencies.trackToAnalytics {
                    analyticsTracker.track(
                        .activityPerform(
                            activity: activity,
                            successfully: successfully,
                            items: dependencies.items
                        )
                    )
                }

                if successfully {
                    logger.log("Successfully performed \(activity.name) activity with [\(items.name)] items", domain: .activity)
                } else {
                    logger.log("Unsuccessfully performed \(activity.name) activity with [\(items.name)] items", domain: .activity)
                }
            }
        }

        let router = ActivityRouterImpl(
            viewController: viewController,
            presentationContext: ModalPresentationContext(
                source: dependencies.source
            )
        )

        return router
    }
}

extension ActivityItem {
    fileprivate var erased: Any {
        switch self {
        case let .image(image):
            return image

        case let .text(string):
            return string

        case let .file(url):
            return url
        }
    }
}

extension LogDomain {
    fileprivate static let activity: Self = "activity"
}
