//
//  MusicViewController.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//

import UIKit

class MusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var songs = [Song]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath)
        //configure cell
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 17)
        //cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else{
            return
        }
        vc.song = songs[indexPath.row]
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        configureSongs()

    }
    
    func configureSongs(){
        songs.append(Song(name: "Song 1", albumName: "Album", artistName: "Artist", trackName: "song1"))
        songs.append(Song(name: "Song 2", albumName: "Album2", artistName: "Artist2", trackName: "song1"))
        songs.append(Song(name: "Song 3", albumName: "Album3", artistName: "Artist3", trackName: "song1"))
        songs.append(Song(name: "Song 4", albumName: "Album4", artistName: "Artist4", trackName: "song1"))
    }
    

}

struct Song{
    let name: String
    let albumName: String
    let artistName: String
    let trackName: String
}
