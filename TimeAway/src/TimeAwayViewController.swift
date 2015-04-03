import Cocoa

class TimeAwayViewController: NSViewController {
    
    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var infoLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupLabels()
    }
   
    func setupBackground() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.blueColor().CGColor
    }
    
    func setupLabels() {
        timeLabel.font = NSFont(name: "Clear Sans", size: 94.0)
        infoLabel.font = NSFont(name: "Clear Sans Light", size: 16.0)
    }
    
    func render(model: TimeAwayPresentationModel) {
        timeLabel.stringValue = model.time
        infoLabel.stringValue = model.info
        
        view.toolTip = model.tooltip
    }
    
    func copyToClipboard() {
        let pasteboard =  NSPasteboard.generalPasteboard()
        pasteboard.declareTypes([NSPasteboardTypeString], owner: nil)
        pasteboard.setString(timeLabel.stringValue, forType: NSPasteboardTypeString)
    }
    
}
