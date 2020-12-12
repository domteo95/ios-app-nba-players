//
//  DetailViewController.swift
//  nbaPlayersApp
//
//  Created by Dominic Teo on 10/14/20.
//

import UIKit

class DetailViewController: UIViewController {

    var player: player!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var assistsLabel: UILabel!
    @IBOutlet weak var reboundLabel: UILabel!
    @IBOutlet weak var ppgLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        print(player!.name, player!.team_name)
        self.nameLabel.text =  player!.name
        self.ppgLabel.text = player!.points_per_game
        self.reboundLabel.text = player!.rebounds_per_game
        self.assistsLabel.text = player!.assists_per_game
        
        DispatchQueue.global(qos: .userInitiated).async {
            let playerImageData = NSData(contentsOf: URL(string: self.player!.imageUrl)!)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: playerImageData! as Data)
                self.imageView.layer.cornerRadius = self.imageView.frame.width/2
            }
        }
        
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
