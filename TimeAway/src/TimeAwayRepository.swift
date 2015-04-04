import Cocoa

class TimeAwayRepository: NSObject {
    
    private let recordLimit = 10

    private var userDefaults: UserDefaults
    private var records: [TimeAwayRecord]

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        self.records = userDefaults.timeAwayRecords
        
        super.init()
    }
    
    var recentRecord: TimeAwayRecord? {
       return records.last
    }

    var allRecords: [TimeAwayRecord] {
        return records
    }
    
    func saveRecord(record: TimeAwayRecord) {
        records.append(record)
        
        if records.count > recordLimit {
            records.removeAtIndex(0)
        }
        
        userDefaults.timeAwayRecords = records
    }
    
}
