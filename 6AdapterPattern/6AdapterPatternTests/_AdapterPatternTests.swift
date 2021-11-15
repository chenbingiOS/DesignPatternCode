//
//  _AdapterPatternTests.swift
//  6AdapterPatternTests
//
//  Created by mtAdmin on 2021/11/12.
//

import XCTest
@testable import _AdapterPattern

class _AdapterPatternTests: XCTestCase {
    
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
 Target: The default target's behavior
 Client: The Adaptee class has a weird interface. See, I don't understand it:
 Adaptee: .eetpadA eht fo roivaheb laicepS
 Client: But I can work with it via the Adapter:
 Adapter: (TRANSLATED)Special behavior of the Adaptee.
 */
class AdapterConceptual: XCTestCase {
    func testAdapterConceptual() {
        print("Client: I can work just fine with the Target objects:")
        Client.someClientCode(target: Target())
        
        let adaptee = Adaptee()
        print("Client: The Adaptee class has a weird interface. See, I don't understand it:")
        print("Adaptee: " + adaptee.specificRequest())
        
        print("Client: But I can work with it via the Adapter:")
        Client.someClientCode(target: Adapter(adaptee))
    }
}


class AdapterRealWorld: XCTestCase {
    /// Example. Let's assume that our app perfectly works with Facebook
    /// authorization. However, users ask you to add sign in via Twitter.
    ///
    /// Unfortunately, Twitter SDK has a different authorization method.
    ///
    /// Firstly, you have to create the new protocol 'AuthService' and insert
    /// the authorization method of Facebook SDK.
    ///
    /// Secondly, write an extension for Twitter SDK and implement methods of
    /// AuthService protocol, just a simple redirect.
    ///
    /// Thirdly, write an extension for Facebook SDK. You should not write any
    /// code at this point as methods already implemented by Facebook SDK.
    ///
    /// It just tells a compiler that both SDKs have the same interface.
    ///
    /// 例子。 让我们假设我们的应用程序与 Facebook 授权完美配合。
    /// 但是，用户会要求您通过 Twitter 添加登录。
    ///
    /// 不幸的是，Twitter SDK 有不同的授权方法。
    ///
    /// 首先，您必须创建新协议“AuthService”并插入 Facebook SDK 的授权方法。
    ///
    /// 其次，为 Twitter SDK 编写一个扩展并实现方法 AuthService 协议，只是一个简单的重定向。
    ///
    /// 第三，为 Facebook SDK 编写一个扩展。
    /// 此时您不应编写任何代码，因为 Facebook SDK 已经实现了这些方法。
    ///
    /// 它只是告诉编译器两个 SDK 具有相同的接口。
    func testAdapterRealWorld() {
        print("Starting an authorization via Facebook")
        startAuthorization(with: FacebookAuthSDK())
        
        print("Starting an authorization via Twitter.")
        startAuthorization(with: TwitterAuthSDK())
    }
    
    func startAuthorization(with service:AuthService) {
        /// The current top view controller of the app
        /// 应用当前的顶视图控制器
        let topViewController = UIViewController()
        service.presentAuthFlow(from: topViewController)
    }
}
