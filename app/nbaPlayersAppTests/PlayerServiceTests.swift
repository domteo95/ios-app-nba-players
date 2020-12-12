//
//  PlayerServiceTests.swift
//  nbaPlayersAppTests
//
//  Created by Dominic Teo on 10/22/20.
//

import XCTest
@testable import nbaPlayersApp

class PlayerServiceTests: XCTestCase {
    var systemUnderTest = PlayerService()

    func testAPI_reutrnsSuccessfulResult() {
        // Given
        var players: [player]!
        var error: Error?
        
        let promise = expectation(description: "Completion handler is invoked")
        
        // When
        self.systemUnderTest.getPlayers(completion: {data, shouldntHappen in
            players = data
            error = shouldntHappen
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        // Then
        XCTAssertNotNil(players)
        XCTAssertNil(error)
    }

}
