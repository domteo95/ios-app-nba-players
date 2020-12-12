//
//  player.swift
//  nbaPlayersApp
//
//  Created by Dominic Teo on 10/8/20.
//

import Foundation

public class player: NSObject,  Codable {
    
    public override var debugDescription: String {
        return "Player(name: \(self.name), team: \(self.team_name))"
    }
    
    var name: String
    var team_name: String
    var team_acronym: String
    var games_played: String
    var minutes_per_game: String
    var field_goals_attempted_per_game: String
    var field_goals_made_per_game: String
    var field_goal_percentage: String
    var free_throw_percentage: String
    var three_point_attempted_per_game: String
    var three_point_made_per_game: String
    var three_point_percentage: String
    var points_per_game: String
    var offensive_rebounds_per_game: String
    var defensive_rebounds_per_game: String
    var rebounds_per_game: String
    var assists_per_game: String
    var steals_per_game: String
    var blocks_per_game: String
    var turnovers_per_game: String
    var player_efficiency_rating: String
    var imageUrl: String = ""
    var injured: Bool = false
    var fav: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case name, team_acronym, team_name, games_played, minutes_per_game, field_goals_attempted_per_game, field_goals_made_per_game, field_goal_percentage, free_throw_percentage, three_point_attempted_per_game, three_point_made_per_game, three_point_percentage, points_per_game, offensive_rebounds_per_game, defensive_rebounds_per_game, rebounds_per_game, assists_per_game, steals_per_game, blocks_per_game, turnovers_per_game, player_efficiency_rating
    }
    
    init(name: String, team_acronym: String, team_name: String, games_played: String, minutes_per_game: String, field_goals_attempted_per_game: String, field_goals_made_per_game: String, field_goal_percentage: String, free_throw_percentage: String, three_point_attempted_per_game: String, three_point_made_per_game: String, three_point_percentage: String, points_per_game: String, offensive_rebounds_per_game: String, defensive_rebounds_per_game: String, rebounds_per_game: String, assists_per_game: String, steals_per_game: String, blocks_per_game: String, turnovers_per_game: String, player_efficiency_rating: String) {
        
        self.name = name
        self.team_acronym = team_acronym
        self.team_name = team_name
        self.games_played = games_played
        self.minutes_per_game = minutes_per_game
        self.field_goals_attempted_per_game = field_goals_attempted_per_game
        self.field_goals_made_per_game = field_goals_made_per_game
        self.field_goal_percentage = field_goal_percentage
        self.free_throw_percentage = free_throw_percentage
        self.three_point_attempted_per_game = three_point_attempted_per_game
        self.three_point_made_per_game = three_point_made_per_game
        self.three_point_percentage = three_point_percentage
        self.points_per_game = points_per_game
        self.offensive_rebounds_per_game = offensive_rebounds_per_game
        self.defensive_rebounds_per_game = defensive_rebounds_per_game
        self.rebounds_per_game = rebounds_per_game
        self.assists_per_game = assists_per_game
        self.steals_per_game = steals_per_game
        self.blocks_per_game = blocks_per_game
        self.turnovers_per_game = turnovers_per_game
        self.player_efficiency_rating = player_efficiency_rating
  
    }
}

