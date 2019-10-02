import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var coreWindow: UIWindow?

    // MARK: - Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        coreWindow = UIWindow(frame: UIScreen.main.bounds)
        coreWindow?.rootViewController = buildFirstModule()
        coreWindow?.makeKeyAndVisible()

        return true
    }

    // MARK: - Private methods
    private func buildFirstModule() -> UIViewController {
        CounterAssembly.assembleCounter()
    }


}

