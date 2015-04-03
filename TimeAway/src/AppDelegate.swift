import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, LockControllerDelegate {
    
    let aboutURL = "https://github.com/fe9lix/TimeAway"
    let hasLaunchedKey = "hasLaunched"
    
    let mainWindowController = MainWindowController(windowNibName: "MainWindow")
    let lockController = LockController()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        setupLockController()
        
        if (isFirstLaunch()) {
            setHasLaunched()
            mainWindowController.bringToFront()
        }
    }
    
    func isFirstLaunch() -> Bool {
        return !NSUserDefaults.standardUserDefaults().boolForKey(hasLaunchedKey)
    }
    
    func setHasLaunched() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: hasLaunchedKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func setupLockController() {
        lockController.delegate = self
    }
    
    func lockController(lockController: LockController, didUnlockScreen timeAwayRecord: TimeAwayRecord) {
        mainWindowController.bringToFront()
        mainWindowController.render(TimeAwayPresentationModel(model: timeAwayRecord))
    }
    
    @IBAction func statusBarShowTapped(sender: AnyObject) {
        mainWindowController.bringToFront()
    }
    
    @IBAction func statusBarAboutTapped(sender: AnyObject) {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string:aboutURL)!)
    }
    
    @IBAction func statusBarQuitTapped(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        
    }
    
}
