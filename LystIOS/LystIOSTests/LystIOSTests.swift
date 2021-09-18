//
//  LystIOSTests.swift
//  LystIOSTests
//
//  Created by HariRamya on 16/09/2021.
//

import XCTest
@testable import LystIOS

class LystIOSTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWrongMockValue() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let data = mockWrongJSON.data(using: .utf8)
        let parsedModel = ApiClient.parse(type: [BreedModel].self, data: data!)
        XCTAssertNil(parsedModel)
    }
    
    func testDummyValue() throws {
        let data = dummyJSON.data(using: .utf8)
        let parsedModel = ApiClient.parse(type: [BreedModel].self, data: data!)
        XCTAssertNotNil(parsedModel)
    }
    
    func testDummyValueParsing() throws {
        let data = dummyJSON.data(using: .utf8)
        let parsedModel = ApiClient.parse(type: [BreedModel].self, data: data!)
        XCTAssertNotNil(parsedModel)
        let vm = MainViewModel()
        let breedList = vm.asSearchModel(breeds: parsedModel!)
        XCTAssertNotNil(breedList)
    }
    
    func testDummyValueCount() throws {
        let data = dummyJSON.data(using: .utf8)
        let parsedModel = ApiClient.parse(type: [BreedModel].self, data: data!)
        XCTAssertNotNil(parsedModel)
        let vm = MainViewModel()
        let breedList = vm.asSearchModel(breeds: parsedModel!)
        XCTAssertNotNil(breedList)
        XCTAssert(breedList?.count == 2)
    }
    
    func testDummyValueImage() throws {
        let data = dummyJSON.data(using: .utf8)
        let parsedModel = ApiClient.parse(type: [BreedModel].self, data: data!)
        XCTAssertNotNil(parsedModel)
        let vm = MainViewModel()
        let breedList = vm.asSearchModel(breeds: parsedModel!)
        XCTAssertNotNil(breedList)
        XCTAssert(breedList?.count == 2)
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            XCTAssertNotNil(breedList?.first?.image)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
    }
    
    func testDummyJSONSearchTool() throws {
        let data = dummySearchJSON.data(using: .utf8)
        let parsedModel = ApiClient.parse(type: [BreedModel].self, data: data!)
        XCTAssertNotNil(parsedModel)
        let vm = MainViewModel()
        let breedList = vm.asSearchModel(breeds: parsedModel!)
        vm.dataProvider = breedList!
        XCTAssertNotNil(breedList)
        vm.searchBarUpdated(text: "American")
        XCTAssert(vm.filteredDataProvider.count == 4)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
