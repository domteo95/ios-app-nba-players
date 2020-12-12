//
//  FavCell.swift
//  nbaPlayersApp
//
//  Created by Dominic Teo on 11/11/20.
//

import UIKit

class FavCell: UITableViewCell {

    var favPlayer: FavList?
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var team: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
