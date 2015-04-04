import Foundation

protocol LockControllerDelegate: class {
    
    func lockController(lockController: LockController, didUnlockScreen: TimeAwayRecord)
    
}

class LockController: NSObject {
   
    weak var delegate: LockControllerDelegate?
    
    private var userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        
        super.init()
        
        registerNotifications()
    }
    
    private func registerNotifications() {
        let notificationCenter = NSDistributedNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "screenLocked", name: "com.apple.screenIsLocked", object: nil)
        notificationCenter.addObserver(self, selector: "screenUnlocked", name: "com.apple.screenIsUnlocked", object: nil)
    }
    
    func screenLocked() {
        userDefaults.lockedAt = NSDate()
    }
    
    func screenUnlocked() {
        let timeAwayRecord = TimeAwayRecord(
            lockedAt: userDefaults.lockedAt ?? NSDate(),
            unlockedAt: NSDate()
        )
        
        delegate?.lockController(self, didUnlockScreen: timeAwayRecord)
    }
    
    deinit {
       NSDistributedNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
