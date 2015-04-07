import Cocoa

protocol StatusBarMenuDelegate: class {
    
    func statusBarMenu(statusBarMenu: StatusBarMenu, didSelectHistoryItem: TimeAwayPresentationModel)
    func statusBarMenuDidClearHistory(statusBarMenu: StatusBarMenu)
    
}

class StatusBarMenu: NSMenu {
    
    @IBOutlet weak var showWhenUnlockedItem: NSMenuItem!
    @IBOutlet weak var historyItem: NSMenuItem!
    
    weak var menuDelegate: StatusBarMenuDelegate?
    
    private var statusBarItem: NSStatusItem!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupStatusBarItem()
    }
    
    private func setupStatusBarItem() {
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
            showWhenUnlockedItem.state = newValue ? NSOnState : NSOffState
        }
    }
    
    var history: [TimeAwayPresentationModel] = [] {
        didSet {
            let historyMenu = NSMenu()
            historyMenu.autoenablesItems = history.count == 0
            
            for model in history.reverse() {
                let historyItem = NSMenuItem(title: model.menuItemTitle, action: "historyItemTapped:", keyEquivalent: "")
                historyItem.target = self
                historyItem.representedObject = model
                historyMenu.addItem(historyItem)
            }
            
            if history.count > 0 {
                historyMenu.addItem(NSMenuItem.separatorItem())
                let clearHistoryItem = NSMenuItem(title: "Clear Entries", action: "historyCleared:", keyEquivalent: "")
                clearHistoryItem.target = self
                historyMenu.addItem(clearHistoryItem)
            } else {
                historyMenu.addItem(NSMenuItem(title: "No Entries", action: nil, keyEquivalent: ""))
            }
            
            setSubmenu(historyMenu, forItem: historyItem)
        }
    }
   
    func historyItemTapped(sender: AnyObject) {
        let model = (sender as NSMenuItem).representedObject as TimeAwayPresentationModel
        
        menuDelegate?.statusBarMenu(self, didSelectHistoryItem: model)
    }
    
    func historyCleared(sender: AnyObject) {
        menuDelegate?.statusBarMenuDidClearHistory(self)
    }
    
}
