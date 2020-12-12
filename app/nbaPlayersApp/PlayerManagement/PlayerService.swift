//
//  FilmService.swift
//  nbaPlayersApp
//
//  Created by Dominic Teo on 10/8/20.
//

import Foundation

class PlayerService {
    func getPlayers() -> [player]{
        return [
            player(named: "Stephen Curry", team: "Warriors", age: 32),
            player(named: "Lebron James", team: "Lakers", age: 35),
            player(named: "Giannis Antetokounmpo", team: "Bucks", age: 25),
            player(named: "Anthony Davis", team: "Lakers", age: 27),
            player(named: "Kevin Durant", team: "Nets", age: 32),
            player(named: "James Harden", team: "Rockets", age: 31),
            player(named: "Joel Embiid", team: "76ers", age: 26),
            player(named: "Nikola Jokic", team: "Nuggets", age: 25),
            player(named: "Jamal Murray", team: "Nuggets", age: 23),
            player(named: "Damian Lillard", team: "Blazers", age: 30),
            player(named: "Jimmy Butler", team: "Heat", age: 31),
            player(named: "Luka Doncic", team: "Mavs", age: 21),
            player(named: "Klay Thompson", team: "Warriors", age: 30),
            player(named: "Zion Williamson", team: "Pelicans", age: 20),
            player(named: "Kawhi Leonard", team: "Clippers", age: 29) ]
    }
}
