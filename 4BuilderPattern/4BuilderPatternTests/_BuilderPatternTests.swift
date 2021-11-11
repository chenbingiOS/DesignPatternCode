//
//  _BuilderPatternTests.swift
//  4BuilderPatternTests
//
//  Created by mtAdmin on 2021/11/11.
//

import XCTest
@testable import _BuilderPattern

class _BuilderPatternTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

/**
 Standard basic product:
 Product parts: PartA

 Standard full featured product:
 Product parts: PartA, PartB, PartC

 Custom product:
 Product parts: PartA, PartC
 */
class BuilderConceptual: XCTestCase {
    func testBuilderConceptual() {
        let director = Director()
        Client.someClientCode(director: director)
    }
}

/**
 Client: Start fetching data from Realm
 RealmQueryBuilder: Initializing RealmProvider with 2 operations:
 RealmProvider: Retrieving data from Realm...
 RealmProvider: excuting the 'filter' operation.
 RealmProvider: excuting the 'limit' operation.
 Client: I have fetched: 0 records.

 Client: Start fetching data from CoreData
 CoreDataQueryBuilder: Initializing CoreDataProvider with 2 operations
 CoreDataProvider: Retrieving data from CoreData...
 CoreDataProvider: exceuting the 'filter' operation.
 CoreDataProvider: exceuting the 'limit' operation.
 Client: I have fetched: 0 records.
 */
class BuilderRealWorld: XCTestCase {
    func testBuilderRealWorld() {
        print("Client: Start fetching data from Realm")
        clientCode(builder: RealmQueryBuilder<User>())
        
        print()
        
        print("Client: Start fetching data from CoreData")
        clientCode(builder: CoreDataQueryBuilder<User>())
    }
    
    fileprivate func clientCode(builder: BaseQueryBuilder<User>) {
        let results = builder.filter({ $0.age < 20 }).limit(1).fetch()
        print("Client: I have fetched: " + String(results.count) + " records.")
    }
}
