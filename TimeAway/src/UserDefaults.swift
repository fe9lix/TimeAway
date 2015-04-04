import Foundation

class UserDefaults {
    
    class var sharedInstance: UserDefaults {
        struct Static {
            static let instance = UserDefaults()
        }
        return Static.instance
    }
    
    private let hasLaunchedKey = "hasLaunched"
    private let reminderEnabledKey = "reminderEnabled"
    private let lockedAtKey = "lockedAt"
    private let timeAwayRecordsKey = "timeAwayRecords"
    
    var hasLaunched: Bool {
        get {
            return boolForKey(hasLaunchedKey)
        }
        set {
            setBool(newValue, forKey: hasLaunchedKey)
        }
    }
    
    var reminderEnabled: Bool {
        get {
            return boolForKey(reminderEnabledKey)
        }
        set {
            setBool(newValue, forKey: reminderEnabledKey)
        }
    }
    
    var lockedAt: NSDate? {
        get {
            return objectForKey(lockedAtKey) as? NSDate
        }
        set {
            setObject(newValue, forKey: lockedAtKey)
        }
    }
    
    var timeAwayRecords: [TimeAwayRecord] {
        get {
            if let data = objectForKey(timeAwayRecordsKey) as? NSData {
                return NSKeyedUnarchiver.unarchiveObjectWithData(data) as [TimeAwayRecord]
            }
            return []
        }
        set {
            let data = NSKeyedArchiver.archivedDataWithRootObject(newValue)
            setObject(data, forKey: timeAwayRecordsKey)
        }
    }
    
    var standardDefaults: NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    
    func boolForKey(key: String) -> Bool {
        return standardDefaults.boolForKey(key)
    }
    
    func setBool(value: Bool, forKey key: String) {
        standardDefaults.setBool(value, forKey: key)
        standardDefaults.synchronize()
    }
    
    func objectForKey(key: String) -> AnyObject? {
        return standardDefaults.objectForKey(key)
    }
    
    func setObject(value: AnyObject?, forKey key: String) {
        standardDefaults.setObject(value, forKey: key)
        standardDefaults.synchronize()
    }
    
}
