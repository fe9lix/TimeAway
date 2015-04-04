import Foundation

class UserDefaults {
    
    class var sharedInstance: UserDefaults {
        struct Static {
            static let instance = UserDefaults()
        }
        return Static.instance
    }
    
    let hasLaunchedKey = "hasLaunched"
    let reminderEnabledKey = "reminderEnabled"
    
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
    
}
