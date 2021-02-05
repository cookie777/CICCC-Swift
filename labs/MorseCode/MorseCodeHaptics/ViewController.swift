
import UIKit
import CoreHaptics

class ViewController: UIViewController {
    var activeMorseCodePlayers: [MorseCodePlayer] = []
    var hapticsPlayer: HapticsMorseCodePlayer?
    
    
    var visualPlayerView: VisualMorseCodePlayerView{
        return view as! VisualMorseCodePlayerView
    }
    
    enum PlayerMode: Int {
        case both, haptic, visual
    }
    
    @IBOutlet var playerModeSegmentedControl: UISegmentedControl!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextField.text = "sos"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check if the device supports Haptics
        if CHHapticEngine.capabilitiesForHardware().supportsHaptics ==
            true {
            do {
                hapticsPlayer = try HapticsMorseCodePlayer()
                configurePlayers(mode: .both)
            } catch {
                presentErrorAlert(title: "Haptics Error",
                                  message: "Failed to start haptics engine.")
                configurePlayers(mode: .visual)
            }
        } else {
            playerModeSegmentedControl.isHidden = false
            configurePlayers(mode: .visual)
        }
    }
    
    
    @IBAction func playerModeSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func playMessage(_ sender: Any) {
        messageTextField.resignFirstResponder() // hied keyboard
        let morseCodeMessage = MorseCodeMessage(message: messageTextField.text ?? "")!
        
        do{
            try visualPlayerView.play(message: morseCodeMessage)
            try hapticsPlayer?.play(message: morseCodeMessage)
        }catch{
            print(error)
        }
        
    }
    
    func presentErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func configurePlayers(mode: PlayerMode){
//        switch mode {
//        case .visual:
//            playerModeSegmentedControl
//        default:
//            <#code#>
//        }
    }
    
    
}

