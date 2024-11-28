
import AppKit
import OSLog
import ScreenSaver

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    private var logger: Logger = Logger(subsystem: Resources.subSystem, category: "AppDelegate")

    var window: NSWindow!
    var saverView: MinimalCountdownView?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let frame = NSRect(x: 0, y: 0, width: 1280, height: 720)   // change size as you like
        logger.log("Starting applicationDidFinishLaunching")
        // Create your screensaver view (isPreview: false = full mode, true = preview mode)
        saverView = MinimalCountdownView(frame: frame, isPreview: false)

        window = NSWindow(
            contentRect: frame,
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )

        window.title = "MinimalCountdown Debug Preview"
        window.contentView = saverView
        window.center()
        window.makeKeyAndOrderFront(nil)

        // Start the animation exactly like the real screensaver does
        saverView?.startAnimation()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        saverView?.stopAnimation()
    }
}
