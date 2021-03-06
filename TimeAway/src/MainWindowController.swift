import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {
    
    private lazy var timeAwayViewController = TimeAwayViewController(nibName: "TimeAwayViewController", bundle: nil)
    private var model: TimeAwayPresentationModel?

    override func windowDidLoad() {
        super.windowDidLoad()
        
        addTimeAwayViewController()
    }
    
    private func addTimeAwayViewController() {
        (window?.contentView as! NSView).addSubview(timeAwayViewController!.view)
    }
    
    func bringToFront() {
        window?.center()
        window?.makeKeyAndOrderFront(self)
        NSApp.activateIgnoringOtherApps(true)
    }
    
    func render(model: TimeAwayPresentationModel?) {
        self.model = model
        
        if window != nil {
            timeAwayViewController!.render(model)
        }
    }
    
    override func keyDown(event: NSEvent) {
        let isCommandKey = event.modifierFlags.rawValue & NSEventModifierFlags.CommandKeyMask.rawValue != 0
        
        if (isCommandKey) {
            let key = event.charactersIgnoringModifiers
            if (key == "c") {
                model?.copyToClipboard()
            }
        }
        
        super.keyDown(event)
    }

}
