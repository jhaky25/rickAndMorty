//
//  CharacterDetailUITest.swift
//  rickAndMortyUITests
//
//  Created by Jaqueline Sanchez lopez on 30/11/25.
//

import XCTest

class CharacterDetailUITest: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["-UITest"]
        app.launch()
    }

    func testCharacterDetailFlow() {
        
        let charactersTable = app.tables["charactersTable"]
        XCTAssertTrue(charactersTable.waitForExistence(timeout: 5))
        
        let firstCell = charactersTable.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        firstCell.tap()
        
        let nameLabel = app.staticTexts["characterNameLabel"]
        XCTAssertTrue(nameLabel.waitForExistence(timeout: 3))
        
        let favoriteButton = app.buttons["favoriteButton"]
        XCTAssertTrue(favoriteButton.exists)
        favoriteButton.tap()
        
        let episodesTable = app.tables["episodesTable"]
        XCTAssertTrue(episodesTable.waitForExistence(timeout: 3))

        let firstEpisodeCell = episodesTable.cells.element(boundBy: 0)
        XCTAssertTrue(firstEpisodeCell.exists)
        firstEpisodeCell.tap()
        
        let mapButton = app.buttons["mapButton"]
        XCTAssertTrue(mapButton.exists)
        mapButton.tap()
        
        let mapView = app.otherElements["characterMapView"]
        XCTAssertTrue(mapView.waitForExistence(timeout: 3))
    }
}
