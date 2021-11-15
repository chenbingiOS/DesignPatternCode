//
//  AdpterPattern.swift
//  6AdapterPattern
//
//  Created by mtAdmin on 2021/11/12.
//

import Foundation

/// The Target defines the domain-specific interface used by the client code.
/// /// Target 定义了客户端代码使用的特定于域的接口。
class Target {
    func request() -> String {
        return "Target: The default target's behavior"
    }
}

/// The Adaptee contains some useful behavior, but its interface is incompatible
/// with the existing client code. The Adaptee needs some adaptation before the
/// client code can use it.
/// Adaptee 包含一些有用的行为，但其接口与现有客户端代码不兼容。
/// 在客户端代码可以使用它之前，Adaptee 需要进行一些调整。
class Adaptee {
    public func specificRequest() -> String {
        return ".eetpadA eht fo roivaheb laicepS"
//        return "Special behavior of the Adaptee."
    }
}

/// The Adapter makes the Adaptee's interface compatible with the Target's
/// interface.
/// Adapter 使 Adaptee 的接口与 Target 的接口兼容。
class Adapter: Target {
    private var adaptee: Adaptee
    
    init(_ adaptee: Adaptee) {
        self.adaptee = adaptee
    }
    
    override func request() -> String {
        return "Adapter: (TRANSLATED)" + adaptee.specificRequest().reversed()
    }
}

/// The client code supports all classes that follow the Target interface.
/// 客户端代码支持所有遵循 Target 接口的类。
class Client {
    static func someClientCode(target: Target) {
        print(target.request())
    }
}
