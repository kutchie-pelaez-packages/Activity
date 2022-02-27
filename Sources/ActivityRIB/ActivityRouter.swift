import CoreRIB
import UIKit

protocol ActivityRouter: AnyObject { }

final class ActivityRouterImpl: Router, ActivityRouter {
    init(
        viewController: UIViewController,
        presentationContext: PresentationContext
    ) {
        self.viewController = viewController
        self.presentationContext = presentationContext
        super.init(id: ActivityRouterIdentifiers.activity)
    }

    private let viewController: UIViewController
    private let presentationContext: PresentationContext

    // MARK: - Router

    override func didRequestAttaching() async {
        await presentationContext.present(viewController)
    }

    override func didRequestDetaching() async {
        await presentationContext.dismiss(viewController)
    }
}
