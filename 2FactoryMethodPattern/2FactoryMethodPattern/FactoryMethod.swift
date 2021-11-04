//
//  FactoryMethod.swift
//  2FactoryMethodPattern
//
//  Created by mtAdmin on 2021/11/4.
//

import Foundation

/// 工厂方法是一种创建型设计模式， 解决了在不指定具体类的情况下创建产品对象的问题。

// MARK: 协议

/// Product 协议声明了所有具体产品必须实现的操作
protocol Product {
    func operation() -> String
}

/// Creator 协议声明了应该返回 Product 类的新对象的工厂方法。
/// Creator 的子类通常提供此方法的实现。
protocol Creator {
    /// 请注意，Creator 也可能提供工厂方法的一些默认实现。
    func factoryMethod() -> Product
        
    /// 另请注意，尽管名称如此，但创建者的主要职责不是创建产品。
    /// 通常，它包含一些依赖于由工厂方法返回的 Product 对象的核心业务逻辑。
    /// 子类可以通过覆盖工厂方法并从中返回不同类型的产品来间接更改该业务逻辑。
    func someOperation() -> String
}

/// 这个扩展实现了 Creator 的默认行为。这种行为可以在子类中被覆盖。
extension Creator {
    func someOperation() -> String {
        // 调用工厂方法创建一个 Product 对象
        let product = factoryMethod()
        
        // 现在，使用产品。
        return "Creator: The same creator's code has just worked with(同一个创建者的代码刚刚使用过)" + product.operation()
    }
}

// MARK: 类实现
/// 具体产品提供产品协议的各种实现。
class ConcreteProduct1: Product {
    func operation() -> String {
        return "{Result of the ConcreteProduct1}"
    }
}

class ConcreteProduct2: Product {
    func operation() -> String {
        return "{Result of the ConcretePruodut2}"
    }
}


/// 具体创建者覆盖工厂方法以更改结果产品的类型。
class ConcreteCreator1: Creator {
    /// 请注意，该方法的签名仍然使用抽象产品类型，即使具体产品实际上是从该方法返回的。
    /// 通过这种方式，创建者可以独立于具体的产品类别。
    func factoryMethod() -> Product {
        return ConcreteProduct1()
    }
}

class ConcreteCreator2: Creator {
    func factoryMethod() -> Product {
        return ConcreteProduct2()
    }
}

/// 客户端代码与具体创建者的实例一起工作，尽管通过其基本协议。
/// 只要客户端通过基本协议继续与创建者合作，您就可以将任何创建者的子类传递给它。
class Client {
    //....
    static func someClientCode(creator: Creator) {
        print("Client: I'm not aware of the creator's class, but it still works.(我不知道创建者的类，但它仍然有效。)\n"
                    + creator.someOperation())
    }
    //....
}
