//
//  PlayerTest.swift
//  nbaPlayersAppTests
//
//  Created by Dominic Teo on 10/22/20.
//

import XCTest
@testable import nbaPlayersApp

class PlayerTest: XCTestCase {

    func testPlayerDebugDescription() throws {
        //Given
        let subjectUnderTest = player(named: "Stephen Curry", team: "Warriors", age: "32", ppg: "20", rpg:"10", apg:"10", imageUrl: "https://www.mercurynews.com/wp-content/uploads/2020/03/BNG-L-WARRIORS-0306-7-1.jpg?w=780")
        
        //When
        let actualValue = subjectUnderTest.debugDescription
        
        //Then
        let expectedValue = "Player(name: Stephen Curry, team: Warriors)"
        XCTAssertEqual(actualValue, expectedValue)
    }

}
