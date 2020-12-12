//
//  NBACell.swift
//  nbaPlayersApp
//
//  Created by Dominic Teo on 10/1/20.
//

import UIKit

class NbaCell: UITableViewCell {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerTeamLabel: UILabel!
    
    @IBOutlet weak var playerImage: UIImageView!
    var player: player?{
        didSet {
            self.playerNameLabel.text = player?.name
            self.playerTeamLabel.text = player?.team_name
            let full_name = player?.name.components(separatedBy: " ")
            
            var first_name = full_name![0]
            if first_name.contains("." ){
                first_name = first_name.replacingOccurrences(of: ".", with: "")
            }
            if first_name.contains("'"){
                first_name = first_name.replacingOccurrences(of: "'", with: "")
            }
            if first_name.contains("Juancho"){
                first_name = "Juan"
            }
            
            let last_name = full_name![1]
            var imageUrl = ""
            if full_name?.count == 2{
                imageUrl = "https://nba-players.herokuapp.com/players/\(last_name)/\(first_name)"
            } else if full_name!.contains("Selden") || full_name!.contains("Matt") {
                imageUrl = "https://nba-players.herokuapp.com/players/\(last_name)/\(first_name)"
            }
            else if full_name?.count == 3{
                var third = full_name![2]
                if third.contains("Jr."){
                    third = third.replacingOccurrences(of: ".", with: "")
                }
                imageUrl = "https://nba-players.herokuapp.com/players/\(last_name)_\(third)/\(first_name)"
                
            }
            player?.imageUrl = imageUrl
            
            DispatchQueue.global(qos: .userInitiated).async {
                let playerImageData = NSData(contentsOf: URL(string: self.player!.imageUrl)!)
                DispatchQueue.main.async {
                    if playerImageData != nil {
                        self.playerImage.image = UIImage(data: playerImageData! as Data)
                        self.playerImage.layer.cornerRadius = self.playerImage.frame.width/2
                    }
                    else{
                        print("IMAGE NOT FOUND")
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
