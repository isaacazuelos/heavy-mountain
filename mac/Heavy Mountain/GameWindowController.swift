import Cocoa

class GameWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.setContentSize(GameConstants.windowContentSize)
    }
}
