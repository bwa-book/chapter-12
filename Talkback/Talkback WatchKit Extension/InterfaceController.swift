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
    
    @IBAction func record() {
        generateAudioUrl()
        
        if let url = audioUrl {
            presentAudioRecorderControllerWithOutputURL(
                url,
                preset: .NarrowBandSpeech,
                options: nil) { didSave, error in
                    if !didSave {
                        self.audioUrl = nil
                    }
                    
                    self.updatePlayButtonState()
            }
        }
    }
    
    @IBAction func play() {
        guard let url = audioUrl else { return }
        
        presentMediaPlayerControllerWithURL(url, options: nil) { finished, endTime, error in
            if finished {
                do {
                    try NSFileManager.defaultManager().removeItemAtURL(url)
                    self.audioUrl = nil
                    self.updatePlayButtonState()
                } catch {}
            }
        }
    }

}
