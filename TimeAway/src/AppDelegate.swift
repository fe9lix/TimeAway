import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, LockControllerDelegate {
    
    @IBOutlet weak var statusBarMenu: StatusBarMenu!
    
    let mainWindowController = MainWindowController(windowNibName: "MainWindow")
    let lockController = LockController()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        updateStatusBarMenu()
        setupLockController()
        bringToFrontOnLaunch()
    }
    
    //MARK: LockController
    
    func setupLockController() {
        lockController.delegate = self
    }
    
    func lockController(lockController: LockController, didUnlockScreen timeAwayRecord: TimeAwayRecord) {
        if UserDefaults.sharedInstance.reminderEnabled {
            mainWindowController.bringToFront()
            mainWindowController.render(TimeAwayPresentationModel(model: timeAwayRecord))
        }
    }
    
    //MARK: MainWindowController
    
    func bringToFrontOnLaunch() {
        if (!UserDefaults.sharedInstance.hasLaunched) {
            UserDefaults.sharedInstance.hasLaunched = true
            mainWindowController.bringToFront()
        }
    }
    
    //MARK: StatusBarMenu
    
    func updateStatusBarMenu() {
        statusBarMenu.showWhenUnlockedEnabled = UserDefaults.sharedInstance.reminderEnabled
    }
    
    @IBAction func statusBarShowRecentTapped(sender: AnyObject) {
        mainWindowController.bringToFront()
    }
    
    @IBAction func statusBarShowWhenUnlockedTapped(sender: AnyObject) {
        statusBarMenu.showWhenUnlockedEnabled = !statusBarMenu.showWhenUnlockedEnabled
        UserDefaults.sharedInstance.reminderEnabled = statusBarMenu.showWhenUnlockedEnabled
    }
    
    @IBAction func statusBarAboutTapped(sender: AnyObject) {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "https://github.com/fe9lix/TimeAway")!)
    }
    
    @IBAction func statusBarQuitTapped(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    //MARK: Termination
    
    func applicationWillTerminate(aNotification: NSNotification) {
        
    }
    
}
