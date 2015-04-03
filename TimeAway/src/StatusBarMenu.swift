import Cocoa

class StatusBarMenu: NSMenu {
    
    var statusBarItem: NSStatusItem!
    
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
    
}
