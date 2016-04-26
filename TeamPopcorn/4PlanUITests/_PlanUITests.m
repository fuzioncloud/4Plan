//
//  _PlanUITests.m
//  4PlanUITests
//
//  Created by Flatiron School on 4/25/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//
#import "_PlanUITests-Swift.h"
#import <XCTest/XCTest.h>

@interface _PlanUITests : XCTestCase

@end

@implementation _PlanUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [Snapshot setupSnapshot:app];
    [app launch];
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
//    XCUIApplication *app = [[XCUIApplication alloc] init];
//    XCUIElement *tpcmainviewNavigationBar = app.navigationBars[@"TPCMainView"];
//    [tpcmainviewNavigationBar.staticTexts[@"10x10 Room"] tap];
//    [[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeImage] elementBoundByIndex:3] tap];
//    [tpcmainviewNavigationBar.buttons[@"4Plan"] tap];
//    [app.tables.staticTexts[@"2x4 Room"] tap];
//    
//    XCUIElement *element = [[[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"TPCMainView"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:4];
//    [[[element childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:2] tap];
//    
//    XCUIElement *element2 = [[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element;
//    [element2 tap];
//    
//    XCUIElement *element4 = [[element2 childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1];
//    XCUIElement *element3 = [[element4 childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0];
//    [[element3 childrenMatchingType:XCUIElementTypeTextField].element tap];
//    [[element3 childrenMatchingType:XCUIElementTypeTextField].element swipeDown];
//    
//    XCUIElement *textField = [[[element4 childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeTextField].element;
//    [textField tap];
//    [textField tap];
//    [app.buttons[@"Save"] tap];
//    [app.alerts[@"Sorry"].collectionViews.buttons[@"okay"] tap];
//    [[[element childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:1] tap];
//    [element pressForDuration:1.5];
//    [app.navigationBars[@"TPCMainView"].buttons[@"addFurnitureButtonSmall"] tap];
//    
//    XCUIElement *tableIndexElement = [[[app.tables childrenMatchingType:XCUIElementTypeOther] matchingIdentifier:@"table index"] elementBoundByIndex:0];
//    [tableIndexElement tap];
//    [tableIndexElement tap];
    
}

@end
