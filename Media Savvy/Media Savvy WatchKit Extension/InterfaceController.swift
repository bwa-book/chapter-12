import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var player: WKInterfaceMovie!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        var posterImage: WKImage?
        if let image = UIImage(named: "poster") {
            posterImage = WKImage(image: image)
        }
        player.setPosterImage(posterImage)
        
        let bundle = NSBundle(forClass: InterfaceController.self)
        if let movieUrl = bundle.URLForResource("FirstSnow", withExtension: "m4v") {
            player.setMovieURL(movieUrl)
        }
    }

}
