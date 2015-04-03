import Cocoa

struct TimeAwayRecord {
   
    let lockedAt: NSDate
    let unlockedAt: NSDate
    
    var duration: NSTimeInterval {
        return unlockedAt.timeIntervalSinceDate(lockedAt)
    }
    
}
