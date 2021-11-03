//
//  Singleton.swift
//  01单例模式
//
//  Created by mtAdmin on 2021/11/3.
//

import Foundation

/// Singleton 类定义了 `shared` 字段，允许客户端访问
/// 唯一的单例实例。
class Singleton {
    
    /// 控制对单例实例访问的静态字段。
    ///
    /// 这个实现让你扩展单例类，同时保持
    /// 每个子类只有一个实例。
    static var shared: Singleton = {
        let instance = Singleton()
        return instance
    }()
    
    /// 单例的初始化程序应该始终是私有的，以防止直接
    /// 使用 `new` 运算符进行构造调用。
    private init() {}
    
    /// 最后，任何单例都应该定义一些业务逻辑，可以是
    /// 在其实例上执行。
    func someBusinessLogic() -> String {
        /// ...
        return "Result of the 'someBusinessLogic' call"
    }
}

/// 单例不应该是可克隆的。
extension Singleton: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

extension Singleton: Equatable {
    static func == (lhs: Singleton, rhs: Singleton) -> Bool {
        return mm_equateableAnyObjecte(object1: lhs, object2: rhs)
    }
    
    static func mm_getAnyObjectMemoryAddress(object: AnyObject) -> String {
        let str = Unmanaged<AnyObject>.passUnretained(object).toOpaque()
        return String(describing: str)
    }
    
    static func mm_equateableAnyObjecte(object1: AnyObject, object2: AnyObject) -> Bool {
        let str1 = mm_getAnyObjectMemoryAddress(object: object1)
        let str2 = mm_getAnyObjectMemoryAddress(object: object2)
        return str1 == str2
    }
}

class Client {
    static func someClientCode() {
        let instance1 = Singleton.shared
        let instance2 = Singleton.shared
        
        if instance1 == instance2 {
            print("是同一个对象 Singleton works, both variables contain the same instance.")
        } else {
            print("不是同一个对象Singleton failed, variables contain different instances.")
        }
    }
}


