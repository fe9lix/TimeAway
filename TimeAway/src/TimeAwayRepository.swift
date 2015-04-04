import Cocoa

class TimeAwayRepository: NSObject {
    
    private let recordLimit = 10
    
    private var records = [TimeAwayRecord]()
    
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
    }
    
}
