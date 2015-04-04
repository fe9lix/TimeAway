import Cocoa

class StatusBarMenu: NSMenu {
    
    var statusBarItem: NSStatusItem!
    
    @IBOutlet weak var showWhenUnlockedItem: NSMenuItem!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupStatusBarItem()
    }
    
    func setupStatusBarItem() {
        statusBarItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1.0)
        statusBarItem.menu = self
        statusBarItem.image = NSImage(named:"icon_statusbar")
        statusBarItem.alternateImage = NSImage(named:"icon_statusbar_alternate")
        statusBarItem.highlightMode = true
    }
    
    var showWhenUnlockedEnabled: Bool {
        get {
            return showWhenUnlockedItem.state == NSOnState
        }
        set {
            showWhenUnlockedItem.state = newValue ? NSOnState  : NSOffState
        }
    }
    
}
