//
//  FavDetailViewController.swift
//  nbaPlayersApp
//
//  Created by Dominic Teo on 11/11/20.
//

import UIKit

class FavDetailViewController: UIViewController {

    var favList: FavList!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var minutes: UILabel!
    @IBOutlet weak var blocks: UILabel!
    @IBOutlet weak var steals: UILabel!
    @IBOutlet weak var assists: UILabel!
    @IBOutlet weak var rebounds: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var perLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectPlayer = favList!
        self.name.text = selectPlayer.name
        self.minutes.text = selectPlayer.minutes
        self.blocks.text = selectPlayer.blocks
        self.assists.text = selectPlayer.assists
        self.rebounds.text = selectPlayer.rebounds
        self.points.text = selectPlayer.points
        self.steals.text = selectPlayer.steals
        self.perLabel.text = selectPlayer.per
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            let playerImageData = NSData(contentsOf: URL(string: selectPlayer.image!)!)
            DispatchQueue.main.async {
                self.image.image = UIImage(data: playerImageData! as Data)
                self.image.layer.cornerRadius = self.image.frame.width/2
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
