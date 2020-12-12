//
//  PlayerListViewControllerTests.swift
//  nbaPlayersAppTests
//
//  Created by Dominic Teo on 10/22/20.
//

import XCTest
@testable import nbaPlayersApp

class PlayerListViewControllerTests: XCTestCase {
    var systemUnderTest: PlayersListViewController!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        self.systemUnderTest = navigationController.topViewController as? PlayersListViewController
        
        UIApplication.shared.windows
            .filter { $0.isKeyWindow }
            .first!
            .rootViewController = self.systemUnderTest
        
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(self.systemUnderTest.view)
    }
    func testTableView_loadsPlayers() {
        //Given
        let mockPlayerService = MockPlayerService()
        let mockPlayers = [
            player(name: "Lebron James", team_acronym: "LAL", team_name: "Los Angeles Lakers", games_played: "35", minutes_per_game: "33", field_goals_attempted_per_game: "10", field_goals_made_per_game: "10", field_goal_percentage: "30", free_throw_percentage: "40", three_point_attempted_per_game: "3", three_point_made_per_game: "2", three_point_percentage: "1", points_per_game: "33", offensive_rebounds_per_game: "3", defensive_rebounds_per_game: "3", rebounds_per_game: "6", assists_per_game: "3", steals_per_game: "4", blocks_per_game: "5", turnovers_per_game: "2", player_efficiency_rating: "33")
        ]
        mockPlayerService.mockPlayers = mockPlayers
        
        self.systemUnderTest.viewDidLoad()
        self.systemUnderTest.playerService = mockPlayerService
        
        XCTAssertEqual(0, self.systemUnderTest.tableView.numberOfRows(inSection: 0))
        
        //When
        self.systemUnderTest.viewWillAppear(false)
        
        //Then
        XCTAssertEqual(mockPlayers.count, self.systemUnderTest.players.count)
        XCTAssertEqual(mockPlayers.count, self.systemUnderTest.tableView.numberOfRows(inSection: 0))
        
    }
    
    class MockPlayerService: PlayerService {
        var mockPlayers: [player]?
        var mockError: Error?
        
        override func getPlayers(completion: @escaping ([player]?, Error?) -> ()) {
            completion(mockPlayers, mockError)
        }
    }


}
