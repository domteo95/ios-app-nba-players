//
//  nba_player.swift
//  nbaPlayersApp
//
//  Created by Dominic Teo on 10/8/20.
//

import Foundation

class player {
    var name: String
    var team: String
    var age: Int
    
    init(named name: String, team: String, age: Int){
        self.name = name
        self.team = team
        self.age = age
    }
}
