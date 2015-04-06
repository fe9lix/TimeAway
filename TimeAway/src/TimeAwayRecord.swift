import Foundation

class TimeAwayRecord: NSObject, NSCoding {
    
    let lockedAt: NSDate
    let unlockedAt: NSDate
    
    var duration: NSTimeInterval {
        return unlockedAt.timeIntervalSinceDate(lockedAt)
    }
    
    init(lockedAt: NSDate, unlockedAt: NSDate) {
        self.lockedAt = lockedAt
        self.unlockedAt = unlockedAt
        
        super.init()
    }
    
    required convenience init(coder decoder: NSCoder) {
        let lockedAt = decoder.decodeObjectForKey("lockedAt") as NSDate
        let unlockedAt = decoder.decodeObjectForKey("unlockedAt") as NSDate
        
        self.init(lockedAt: lockedAt, unlockedAt: unlockedAt)
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(lockedAt, forKey: "lockedAt")
        coder.encodeObject(unlockedAt, forKey: "unlockedAt")
    }
    
}
