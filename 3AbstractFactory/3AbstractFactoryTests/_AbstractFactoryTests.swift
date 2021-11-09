//
//  _AbstractFactoryTests.swift
//  3AbstractFactoryTests
//
//  Created by mtAdmin on 2021/11/9.
//

import XCTest
@testable import _AbstractFactory

class _AbstractFactoryTests: XCTestCase {

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
 Client: Testing client code with the first factory type:
 The result of the product B1.
 The result of the B1 collaborating with the (The result of the product A1.)
 Client: Testing the same client code with the second factory type:
 The result of the product B2.
 The result of the B2 collaborating with the (The result of the product A2.)
 */
class AbstractFactoryConceptual: XCTestCase {
    func testAbstractFactoryConceptual() {
        /// 客户端代码可以与任何具体的工厂类一起使用。
        print("Client: Testing client code with the first factory type:")
        Client.someClientCode(factory: ConcreteFactory1())
        print("Client: Testing the same client code with the second factory type:")
        Client.someClientCode(factory: ConcreteFactory2())
    }
}

/**
 
 Teacher View has been created
 Teacher View Controller has been created
 Login screen has been presented
 Teacher View has been created
 Teacher View Controller has been created
 Sign up screen has been presented
 
 Student View has been created
 Student View Controller has been created
 Login screen has been presented
 Student View has been created
 Student View Controller has been created
 Sign up screen has been presented
 */
class AbstractFactoryRealWorld: XCTestCase {
    func testAbstractFactoryRealWorld() {
        #if teacherMode
        let clientCode = ClientCode(factoryType: TeacherAuthViewFactory.self)
        #else
        let clientCode = ClientCode(factoryType: StudentAuthViewFactory.self)
        #endif
        
        /// Present LogIn flow
        /// 当前登录流程
        clientCode.presentLogin()
        print("Login screen has been presented")

        /// Present SignUp flow
        /// 当前注册流程
        clientCode.presentSignUp()
        print("Sign up screen has been presented")
        
    }
}
