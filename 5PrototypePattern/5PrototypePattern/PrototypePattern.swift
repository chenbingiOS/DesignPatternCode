//
//  PrototypePattern.swift
//  5PrototypePattern
//
//  Created by mtAdmin on 2021/11/12.
//

import Foundation

/// Swift has built-in cloning support. To add cloning support to your class,
/// you need to implement the NSCopying protocol in that class and provide the
/// implementation for the `copy` method.
/// Swift 有内置的克隆支持。
/// 要为您的类添加克隆支持，您需要在该类中实现 NSCopying 协议并提供 `copy` 方法的实现。
class BassClass: NSCopying, Equatable {

    private var intValue = 1
    private var stringValue = "Value"
    
    /// required修饰符的使用规则
    /// 1.required修饰符只能用于修饰类初始化方法。
    /// 2.当子类含有异于父类的初始化方法时（初始化方法参数类型和数量异于父类），
    /// 子类必须要实现父类的required初始化方法，并且也要使用required修饰符而不是override。
    /// 3.当子类没有初始化方法时，可以不用实现父类的required初始化方法。
    required init(initValue: Int = 1, stringValue: String = "Value") {
        self.intValue = initValue
        self.stringValue = stringValue
    }

    // NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let prototype = type(of: self).init()
        prototype.intValue = intValue
        prototype.stringValue = stringValue
        print("Values defined in BaseClass have been cloned!")
        return prototype
    }
    
    // Equatable
    static func == (lhs: BassClass, rhs: BassClass) -> Bool {
        return lhs.intValue == lhs.intValue && lhs.stringValue == lhs.stringValue
    }
}

/// Subclasses can override the base `copy` method to copy their own data into
/// the resulting object. But you should always call the base method first.
/// 子类可以覆盖基本的`copy`方法，将自己的数据复制到结果对象中。
/// 但是您应该始终首先调用基本方法。
class SubClass: BassClass {
    private var boolValue = true
    
    func copy() -> Any {
        return copy(with: nil)
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        guard let prototype = super.copy(with: zone) as? SubClass else {
            return SubClass() // oops
        }
        prototype.boolValue = boolValue
        print("Values defined in SubClass have been cloned!")
        return prototype
    }
}


