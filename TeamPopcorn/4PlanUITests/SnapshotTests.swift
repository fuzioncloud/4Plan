//
//  SnapshotTests.swift
//  4Plan
//
//  Created by Flatiron School on 4/25/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

import XCTest

class SnapshotTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        setupSnapshot(app)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        
//        let app = XCUIApplication()
//        snapshot("00")
//        
//        app.navigationBars["4Plan"].buttons["Add"].tap()
//        snapshot("01")
//        
//        app.buttons["2x4"].tap()
//        snapshot("02")
//        app.navigationBars["TPCMainView"].buttons["addFurnitureButtonSmall"].tap()
//        snapshot("03")
//        app.tables.childrenMatchingType(.Other).matchingIdentifier("table index").elementBoundByIndex(0).tap()
//        snapshot("04")
        
        
        let app = XCUIApplication()
        snapshot("00")
        let tablesQuery = app.tables
        tablesQuery.staticTexts["10sq"].tap()
        snapshot("01")
        
        let tpcmainviewNavigationBar = app.navigationBars["TPCMainView"]
        tpcmainviewNavigationBar.buttons["addFurnitureButtonSmall"].tap()
        snapshot("02")
//        tablesQuery.childrenMatchingType(.Other).matchingIdentifier("table index").elementBoundByIndex(0).tap()
        snapshot("03")
        let element = app.otherElements.containingType(.NavigationBar, identifier:"TPCMainView").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(4)
        element.tap()
        snapshot("04")
//        element.childrenMatchingType(.Button).elementBoundByIndex(4).tap()
//        snapshot("05")
//        app.otherElements["PopoverDismissRegion"].tap()
//        snapshot("06")
        tpcmainviewNavigationBar.staticTexts["10sq"].tap()
        snapshot("07")
        app.buttons["Done"].tap()
        snapshot("08")
        app.buttons["saveicon"].tap()
        snapshot("09")
        app.buttons["Button"].tap()
        snapshot("10")
    }

}
