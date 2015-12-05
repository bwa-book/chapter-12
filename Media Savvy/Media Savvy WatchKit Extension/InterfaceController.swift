import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var button: WKInterfaceButton!
    
    @IBAction func play() {
        let bundle = NSBundle(forClass: InterfaceController.self)
        if let movieUrl = bundle.URLForResource("FirstSnow", withExtension: "m4v") {
            presentMediaPlayerControllerWithURL(movieUrl, options: nil) { finished, endTime, error in
                
            }
        }
    }

}
