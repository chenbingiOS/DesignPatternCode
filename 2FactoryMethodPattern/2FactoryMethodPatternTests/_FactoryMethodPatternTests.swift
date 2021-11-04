//
//  _FactoryMethodPatternTests.swift
//  2FactoryMethodPatternTests
//
//  Created by mtAdmin on 2021/11/4.
//

import XCTest
@testable import _FactoryMethodPattern

class _FactoryMethodPatternTests: XCTestCase {

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
 App: Launched with the ConcreteCreator1.
 Client: I'm not aware of the creator's class, but it still works.
 Creator: The same creator's code has just worked with {Result of the ConcreteProduct1}

 App: Launched with the ConcreteCreator2.
 Client: I'm not aware of the creator's class, but it still works.
 Creator: The same creator's code has just worked with {Result of the ConcreteProduct2}
 **/
class FactoryMethodConceptual: XCTestCase {
    /// 应用程序根据创建者的类型选择创建者的类型配置或环境。
    func testFactoryMethodConceptual() {
        print("App: Launched with the ConcreteCreator1.")
        Client.someClientCode(creator: ConcreteCreator1())
        print("App: Launched with the ConcreteCreator2.")
        Client.someClientCode(creator: ConcreteCreator2())
    }
}
