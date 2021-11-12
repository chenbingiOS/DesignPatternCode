//
//  _PrototypePatternTests.swift
//  5PrototypePatternTests
//
//  Created by mtAdmin on 2021/11/12.
//

import XCTest
@testable import _PrototypePattern

class _PrototypePatternTests: XCTestCase {

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

class Client {
    static func someClinetCode() {
        let original = SubClass(initValue: 2, stringValue: "Value2")
        
        guard let copy = original.copy() as? SubClass else {
            XCTAssert(false)
            return
        }
        
        /// See implementation of `Equatable` protocol for more details.
        XCTAssert(copy == original)
        
        print("The original object is equal to the copied object!")
    }
}

class PrototyConceptual: XCTestCase {
    func testPrototype_NSCopying () {
        Client.someClinetCode()
    }
}

class PrototypeRealWorld: XCTestCase {
    func testPrototypeRealWorld() {
        let author = Author(id: 10, username: "Ivan_83")
        let page = Page(title: "My First Page", contents: "Hello world!", auther: author)
                
        page.add(comment: Comment(message: "Keep it up!"))
        
        /// Since NSCopying returns Any, the copied object should be unwrapped.
        /// 由于 NSCopying 返回 Any，复制的对象应该被解包。
        guard let anotherPage = page.copy() as? Page else {
            XCTFail("Page was not copied")
            return
        }
        
        /// Comments should be empty as it is a new page.
        /// 注释应该是空的，因为它是一个新页面。
        XCTAssert(anotherPage.comments.isEmpty)
        
        /// Note that the author is now referencing two objects.
        /// 请注意，author现在正在引用两个对象。
        XCTAssert(author.pageCount == 2)
        
        print("Original title:" + page.title)
        print("Copied title:" + anotherPage.title)
        print("Count of pages:" + String(author.pageCount))
    }
}
