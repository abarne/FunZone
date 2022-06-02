//
//  PlayerViewController.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//

import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []
    
    //@IBOutlet var holder: UIView!
    
//    private let albumImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
//    private let songNameLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        return label
//    }()
//    private let artistNameLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        return label
//    }()
//    private let albumNameLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        return label
//    }()
    
    
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //if holder.subviews.count == 0{
          //  configure()
       // }
    }
    
    func configure(){
        //set up player
        let song = songs[position]
        
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        do{
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else {
                print("url string is nil")
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            guard let player = player else {
                print("or this is nil")
                return
            }
            player.play()

        }catch{
            print("error configuring")
        }
        //set up user interface elements
//        albumImageView.frame = CGRect(x: 10, y: 10, width: view.frame.size.width-70, height: view.frame.size.width-70)
//        albumImageView.image = UIImage(systemName: "music.note")
//
//        //labels
//        songNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height+10, width: holder.frame.size.width-20, height: 70)
//        albumNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height+80, width: holder.frame.size.width-20, height: 70)
//        artistNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height+150, width: holder.frame.size.width-20, height: 70)
//
//        songNameLabel.text = song.name
//        albumNameLabel.text = song.albumName
//        artistNameLabel.text = song.artistName
//
//        holder.addSubview(albumImageView)
//        holder.addSubview(songNameLabel)
//        holder.addSubview(albumNameLabel)
//        holder.addSubview(artistNameLabel)
        
        //player controls
        
        //slider
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }

}
