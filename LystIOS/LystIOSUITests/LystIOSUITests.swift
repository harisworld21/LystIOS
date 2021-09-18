//
//  LystIOSUITests.swift
//  LystIOSUITests
//
//  Created by HariRamya on 16/09/2021.
//

import XCTest

class LystIOSUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSimpleLaunch() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        

        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .searchField).element.tap()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Abyssinian").element.tap()
        
        let element = app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 0)
        element/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeDown()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        element/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeDown()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        element.swipeDown()
        element.swipeDown()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSearchItem() throws {
        //Search and find American Shorthair
        let app = XCUIApplication()
        app.launch()
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"American Shorthair").children(matching: .other).element.swipeUp()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .searchField).element.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"American Shorthair").element.tap()
    }
    
    func testWikipediaForBengalCat() throws {
        //Search and find American Shorthair
        
        let app = XCUIApplication()
        app.launch()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .searchField).element.tap()
//        app.searchFields.containing(.button, identifier:"Clear text").element.tap()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"American Curl").element.tap()
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Preview Detail in Wikipedia"]/*[[".buttons[\"Preview Detail in Wikipedia\"].staticTexts[\"Preview Detail in Wikipedia\"]",".staticTexts[\"Preview Detail in Wikipedia\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
