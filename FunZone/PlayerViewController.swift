//
//  PlayerViewController.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//

import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
    public var song: Song?

    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var songTimeSlider: UISlider!
    var player: AVAudioPlayer?
    
    @IBAction func sliderAction(_ sender: Any) {
        print(songTimeSlider.value)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        songNameLabel.text = song?.trackName
        artistNameLabel.text = song?.artistName
        albumNameLabel.text = song?.albumName
        let filePath = Bundle.main.path(forResource: songNameLabel.text, ofType: "mp3")
        let url = URL(fileURLWithPath: filePath!)
        do{
            player = try AVAudioPlayer(contentsOf: url)
        }catch{
            print("error creating player")
        }
    }
    
    
    @IBAction func playButton(_ sender: Any) {
        player?.play()
        print("music is playing")
    }
    
    @IBAction func stopButton(_ sender: Any) {
        player?.stop()
        print("music is stopped")
    }
}
