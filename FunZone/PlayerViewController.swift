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

    var player: AVAudioPlayer?
    var timer : Timer?
    var myTime : Float = 0.0
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    

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
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        print("music is playing")
    }
    
    @IBAction func stopButton(_ sender: Any) {
        player?.stop()
        timer?.invalidate()
        progressBar.setProgress(0.0, animated: true)
        myTime = 0.0
        print("music is stopped")
    }
    
    @objc func updateTime(){
        myTime = myTime + 0.01
        progressBar.setProgress(myTime, animated: true)
    }
    
}
