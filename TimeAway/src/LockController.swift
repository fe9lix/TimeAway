import Foundation

protocol LockControllerDelegate {
    
    func lockController(lockController: LockController, didUnlockScreen: TimeAwayRecord)
    
}

class LockController {
   
    var delegate: LockControllerDelegate?
    var lockedAt: NSDate?
    
    init() {
        registerNotifications()
    }
    
    func registerNotifications() {
        let notificationCenter = NSDistributedNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "screenLocked", name: "com.apple.screenIsLocked", object: nil)
        notificationCenter.addObserver(self, selector: "screenUnlocked", name: "com.apple.screenIsUnlocked", object: nil)
    }
    
    func screenLocked() {
        lockedAt = NSDate()
    }
    
    func screenUnlocked() {
        let timeAwayRecord = TimeAwayRecord(
            lockedAt: lockedAt!,
            unlockedAt: NSDate()
        )
        
        delegate?.lockController(self, didUnlockScreen: timeAwayRecord)
    }
    
    deinit {
       NSDistributedNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
