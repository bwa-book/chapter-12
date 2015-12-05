import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var recordButton: WKInterfaceButton!
    @IBOutlet var playButton: WKInterfaceButton!
    
    private var audioUrl: NSURL?
    private func updatePlayButtonState() {
        playButton.setEnabled(audioUrl != nil)
    }
    
    override func willActivate() {
        super.willActivate()
        
        updatePlayButtonState()
    }
    
    private func generateAudioUrl() {
        let containerUrl = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.build.watchosapps")!
        let filename = String(NSDate().timeIntervalSince1970)
        
        audioUrl = containerUrl.URLByAppendingPathComponent("\(filename).m4a")
    }

}
