import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var button: WKInterfaceButton!
    
    var playbackPosition: NSTimeInterval = 0
    
    @IBAction func play() {
        let bundle = NSBundle(forClass: InterfaceController.self)
        if let movieUrl = bundle.URLForResource("FirstSnow", withExtension: "m4v") {
            let playerOptions = [
                WKMediaPlayerControllerOptionsStartTimeKey: playbackPosition
            ]
            presentMediaPlayerControllerWithURL(movieUrl, options: playerOptions) { finished, endTime, error in
                self.playbackPosition = finished ? 0 : endTime
            }
        }
    }
    
    @IBOutlet var backgroundButton: WKInterfaceButton!
    @IBAction func toggleBackgroundPlayback() {
        
    }

}
