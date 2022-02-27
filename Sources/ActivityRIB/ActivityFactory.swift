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

        @Weak var logger = dependencies.logger
        @Weak var analyticsTracker = dependencies.analyticsTracker
        viewController.completionWithItemsHandler = { [weak delegate = dependencies.delegate] activityType, successfully, items, error in
            defer { delegate?.activityDidRequestClosing() }

            let activity = activityType?.rawValue ?? "UNKNOWN"

            if let error = error {
                logger?.error("Failed to perform \(activity) activity, error: \(error.localizedDescription)", domain: .activityRIB)
                safeCrash()
            } else {
                if dependencies.trackToAnalytics {
                    analyticsTracker?.track(
                        .activityPerform(
                            activity: activity,
                            successfully: successfully,
                            items: dependencies.items
                        )
                    )
                }

                if successfully {
                    logger?.log("Successfully performed \(activity) activity", domain: .activityRIB)
                } else {
                    logger?.log("Unsuccessfully performed \(activity) activity", domain: .activityRIB)
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
    fileprivate static let activityRIB: Self = "activityRIB"
}
