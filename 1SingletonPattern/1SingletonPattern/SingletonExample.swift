//
//  SingletonExample.swift
//  1SingletonPattern
//
//  Created by mtAdmin on 2021/11/3.
//

import Foundation
import UIKit

/// 单例设计模式
///
/// 意图：确保类只有一个实例，并提供一个全局点
/// 访问它。


/// 消息模型
struct Message {
    let id: Int
    let text: String
}

/// 订阅者协议回调事件
protocol MessageSubscriber {
    func accept(new message: [Message])
    func accept(remove message: [Message])
}

/// 消息通讯服务提供者
protocol MessageService {
    func add(subseriber: MessageSubscriber)
}

class FriendsChatService: MessageService {
    
    static let shared = FriendsChatService()
    /// 订阅者数组
    private var subscribers = [MessageSubscriber]()
    
    func add(subseriber: MessageSubscriber) {
        /// 在本例中，通过添加新订阅者再次开始获取
        subscribers.append(subseriber)
        /// 请注意，当添加第二个订阅者时，第一个订阅者将再次收到消息
        startFetching()
    }
    
    func startFetching() {
        /// 设置网络栈，建立连接...
        /// ...并从服务器检索数据
        let newMessage = [Message(id: 0, text: "Text0"),
                          Message(id: 5, text: "Test5"),
                          Message(id: 10, text: "Test10")]
        let removeMessage = [Message(id: 1, text: "Test0")]
        
        /// 将更新的数据发送给订阅者
        receivedNew(message: newMessage)
        receivedRemoved(message: removeMessage)
    }
}

private extension FriendsChatService {
    func receivedNew(message: [Message]) {
        /// 订阅者收到消息
        subscribers.forEach { item in
            item.accept(new: message)
        }
    }
    
    func receivedRemoved(message: [Message]) {
        /// 订阅者移除消息
        subscribers.forEach { item in
            item.accept(remove: message)
        }
    }
}

// MARK: VC
class BaseVC: UIViewController, MessageSubscriber {
    func accept(new message: [Message]) {
        // 在 base 类里面回调新消息
    }
    
    func accept(remove message: [Message]) {
        // 在 base 类里面移除消息
    }
    
    func startReceiveMessage() {
        /// 单例可以作为依赖项注入。然而，从一个
        /// 从信息的角度来看，此示例调用FriendsChatService
        /// 直接说明模式的意图，即：“…以
        /// 提供实例的全局访问点…”
        FriendsChatService.shared.add(subseriber: self)
    }
}


class MessageListVC: BaseVC {
    override func accept(new message: [Message]) {
        print("MessageListVC accepted 'new messages'")
        /// 在子类回调新的消息
    }
    
    override func accept(remove message: [Message]) {
        print("MessageListVC accepted 'remove messages'")
        /// 在子类回调移除消息
    }
    
    override func startReceiveMessage() {
        print("MessageListVC starts receive message")
        super.startReceiveMessage()
    }
}

class ChatVC: BaseVC {
    override func accept(new message: [Message]) {
        print("ChatVC accepted 'new messages'")
        /// 在子类回调新的消息
    }
    
    override func accept(remove message: [Message]) {
        print("ChatVC accepted 'remove messages'")
        /// 在子类回调移除消息
    }
    
    override func startReceiveMessage() {
        print("ChatVC starts receive message")
        super.startReceiveMessage()
    }
}
