import Foundation

class TimeAwayPresentationModel {
    
    private let model: TimeAwayRecord
    
    let timeFormatter: NSDateFormatter = {
        let timeFormatter = NSDateFormatter()
        timeFormatter.locale = NSLocale(localeIdentifier: "en_US")
        timeFormatter.dateFormat = "HH:mm"
        
        return timeFormatter
        }()
    
    let dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        
        return dateFormatter
        
    }()
    
    var time: String {
        let durationInMinutes = Int(model.duration / 60.0)
        let hours = durationInMinutes / 60
        
        if (hours > 99) {
            return "∞"
        }
        
        let minutes = durationInMinutes % 60
       
        let hoursStr = hours >= 10 ? String(hours) : "0" + String(hours)
        let minutesStr = minutes >= 10 ? String(minutes) : "0" + String(minutes)
       
        return "\(hoursStr):\(minutesStr)"
    }
    
    var info: String {
        let locked = timeFormatter.stringFromDate(model.lockedAt)
        let unlocked = timeFormatter.stringFromDate(model.unlockedAt)
        
        return "Locked: \(locked)  |  Unlocked: \(unlocked)"
    }
    
    var tooltip: String {
        let locked = dateFormatter.stringFromDate(model.lockedAt)
        let unlocked = dateFormatter.stringFromDate(model.unlockedAt)
        
        return "Locked: \(locked)\nUnlocked: \(unlocked)"
    }
    
    init(model: TimeAwayRecord) {
        self.model = model
    }
    
}
