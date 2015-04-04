import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, LockControllerDelegate, StatusBarMenuDelegate {
    
    @IBOutlet weak var statusBarMenu: StatusBarMenu!
    
    let mainWindowController = MainWindowController(windowNibName: "MainWindow")
    let lockController = LockController(userDefaults: UserDefaults.sharedInstance)
    let timeAwayRepository = TimeAwayRepository()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        setupStatusBarMenu()
        setupLockController()
        showRecentRecordAfterLaunch()
    }
    
    //MARK: LockController
    
    private func setupLockController() {
        lockController.delegate = self
    }
    
    func lockController(lockController: LockController, didUnlockScreen timeAwayRecord: TimeAwayRecord) {
        timeAwayRepository.saveRecord(timeAwayRecord)
        
        updateStatusBarMenu()
        
        if UserDefaults.sharedInstance.reminderEnabled {
            showRecentRecord()
        }
    }
    
    //MARK: MainWindowController
    
    private func showRecentRecordAfterLaunch() {
        if !UserDefaults.sharedInstance.hasLaunched {
            UserDefaults.sharedInstance.hasLaunched = true
            showRecentRecord()
        }
    }
    
    private func showRecentRecord() {
        mainWindowController.bringToFront()
        
        if let recentRecord = timeAwayRepository.recentRecord {
            mainWindowController.render(TimeAwayPresentationModel(model: recentRecord))
        }
    }
    
    //MARK: StatusBarMenu
    
    private func setupStatusBarMenu() {
        statusBarMenu.menuDelegate = self
        statusBarMenu.showWhenUnlockedEnabled = UserDefaults.sharedInstance.reminderEnabled
        
        updateStatusBarMenu()
    }
    
    private func updateStatusBarMenu() {
        statusBarMenu.history = timeAwayRepository.allRecords.map { record in TimeAwayPresentationModel(model: record) }
    }
    
    @IBAction func statusBarShowRecentTapped(sender: AnyObject) {
        showRecentRecord()
    }
    
    @IBAction func statusBarShowWhenUnlockedTapped(sender: AnyObject) {
        statusBarMenu.showWhenUnlockedEnabled = !statusBarMenu.showWhenUnlockedEnabled
        UserDefaults.sharedInstance.reminderEnabled = statusBarMenu.showWhenUnlockedEnabled
    }
    
    func statusBarMenu(statusBarMenu: StatusBarMenu, didSelectHistoryItem model: TimeAwayPresentationModel) {
        model.copyToClipboard()
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
