//
//  RickandMortyTests.swift
//  RickandMortyTests
//
//  Created by Vladislav Shchukin on 18.06.2022.
//

import XCTest
@testable import Rick_and_Morty

class RickandMortyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSavingAndGettingTabFromStorage() throws {
        let storage: TabStorage = TabStorageImpl()
        let tab = Tab.search
        storage.saveTab(tab)
        let result = storage.getTab()
        assert(result==tab)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
