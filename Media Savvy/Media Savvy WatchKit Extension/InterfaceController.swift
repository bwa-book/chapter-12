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
        isPlaying = !isPlaying
        
        if (isPlaying) {
            startBackgroundPlayback()
        } else {
            stopBackgroundPlayback()
        }
        
        updateBackgroundButton()
    }
    
    var isPlaying = false
    private func updateBackgroundButton() {
        if (isPlaying) {
            backgroundButton.setTitle("Stop Music")
        } else {
            backgroundButton.setTitle("Play Music")
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        updateBackgroundButton()
    }
    
    // MARK: Background audio
    private var musicItem: WKAudioFilePlayerItem?
    private var backgroundPlayer: WKAudioFilePlayer?
    
    private func startBackgroundPlayback() {
        prepareAudioItemAndPlayer()
        guard let _ = musicItem, backgroundPlayer = backgroundPlayer else { return }
        
        backgroundPlayer.play()
    }
    
    private func stopBackgroundPlayback() {
        guard let backgroundPlayer = backgroundPlayer else { return }
        
        backgroundPlayer.pause()
    }
    
    private func prepareAudioItemAndPlayer() {
        guard musicItem == nil else { return }
        
        let bundle = NSBundle(forClass: InterfaceController.self)
        if let audioUrl = bundle.URLForResource("music", withExtension: "mp3") {
            let asset = WKAudioFileAsset(
                URL: audioUrl,
                title: "Music!",
                albumTitle: "Build watchOS Apps",
                artist: "Emandem"
            )
            
            musicItem = WKAudioFilePlayerItem(asset: asset)
            if let musicItem = musicItem {
                backgroundPlayer = WKAudioFilePlayer(playerItem: musicItem)
            }
        }
    }

}
