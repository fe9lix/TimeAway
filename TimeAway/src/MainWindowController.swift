import Cocoa

class MainWindowController: NSWindowController {
    
    var timeAwayViewController: TimeAwayViewController!

    override func windowDidLoad() {
        super.windowDidLoad()
        
        addTimeAwayViewController()
    }
    
    func addTimeAwayViewController() {
        timeAwayViewController = TimeAwayViewController(nibName: "TimeAwayViewController", bundle: nil)
        
        (window?.contentView as NSView).addSubview(timeAwayViewController.view)
    }
    
    func bringToFront() {
        NSApp.activateIgnoringOtherApps(true)
        window?.center()
        window?.makeKeyAndOrderFront(self)
    }
    
    func render(model: TimeAwayPresentationModel) {
        timeAwayViewController.render(model)
    }
    
    override func keyDown(event: NSEvent) {
        let isCommandKey = event.modifierFlags.rawValue & NSEventModifierFlags.CommandKeyMask.rawValue != 0
        
        if (isCommandKey) {
            let key = event.charactersIgnoringModifiers
            if (key == "c") {
                timeAwayViewController.copyToClipboard()
            }
        }
        
        super.keyDown(event)
    }

}
