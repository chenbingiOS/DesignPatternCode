//
//  _SingletonPatternTests.swift
//  1SingletonPatternTests
//
//  Created by mtAdmin on 2021/11/3.
//

import XCTest
@testable import _SingletonPattern

class _SingletonPatternTests: XCTestCase {

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

class SingletonConceptual: XCTestCase {
    func testSingletonConceptual() {
        Client.someClientCode()
    }
}


class SingletonRealWorld: XCTestCase {
    /**
     MessageListVC starts receive message
     MessageListVC accepted 'new messages'
     MessageListVC accepted 'remove messages'
     --
     从这开始，第二个订阅者开始接收消息
     --
     ChatVC starts receive message
     MessageListVC accepted 'new messages'
     ChatVC accepted 'new messages'
     MessageListVC accepted 'remove messages'
     ChatVC accepted 'remove messages'
     **/
    func testSingletonRealWorld() {
        /// 有两个视图控制器。
        ///
        /// MessagesListVC 显示来自用户聊天的最后消息列表。
        /// ChatVC 显示与朋友的聊天。
        ///
        /// FriendsChatService 从服务器获取消息并提供所有
        /// 订阅者（我们示例中的视图控制器）具有新的和移除的
        /// 消息。
        ///
        /// FriendsChatService 被两个视图控制器使用。 有可能
        /// 实现为类的实例以及全局变量。
        ///
        /// 在这个例子中，只有一个实例是很重要的
        /// 执行资源密集型工作。
        
        let listVC = MessageListVC()
        let chatVC = ChatVC()
        
        listVC.startReceiveMessage()
        chatVC.startReceiveMessage()
        
        /// ... 将视图控制器添加到导航堆栈 ...
    }
}
