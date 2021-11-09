//
//  AbstractFactory.swift
//  3AbstractFactory
//
//  Created by mtAdmin on 2021/11/9.
//

import Foundation


// MARK: 协议

/// 产品系列中的每个不同产品都应该有一个基本协议。
/// 产品的所有变体都必须执行此协议。
protocol AbstractProductA {
    func usefulFunctionA() -> String
}


// MARK: 具体对象
/// 具体产品由相应的具体工厂创建。
class ConcreteProductA1: AbstractProductA {
    func usefulFunctionA() -> String {
        return "The result of the product A1"
    }
}

class ConcreteProductA2: AbstractProductA {
    func usefulFunctionA() -> String {
        return "The result of the product A2"
    }
}

// MARK: 协议
/// 另一个产品的基础协议。
/// 所有产品都可以相互交互，但只有在具有相同具体变体的产品之间才能进行适当的交互。
protocol AbstractProductB {
    /// ProductB 能够做自己的事情...
    func usefulFunctionB() -> String
    /// ... 但它也可以与 ProductA 协作。
    ///
    /// 抽象工厂确保它创建的所有产品都属于相同的变体，因此兼容。
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String
}

// MARK: 具体对象
/// Concrete Products are created by corresponding Concrete Factories.
/// 具体产品由相应的具体工厂创建。
class ConcreteProductB1: AbstractProductB {
    func usefulFunctionB() -> String {
        return "The result of the product B1"
    }
    
    /// This variant, Product B1, is only able to work correctly with the
    /// variant, Product A1. Nevertheless, it accepts any instance of
    /// AbstractProductA as an argument.
    /// 此变体产品 B1 只能与变体产品 A1 一起正常工作。
    /// 然而，它接受 AbstractProductA 的任何实例作为参数。
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String {
        let result = collaborator.usefulFunctionA()
        return "The result of the B1 collaborating with the (\(result))"
    }
}

class ConcreteProductB2: AbstractProductB {
    func usefulFunctionB() -> String {
        return "The result of the product B2"
    }
    
    /// This variant, Product B2, is only able to work correctly with the
    /// variant, Product A2. Nevertheless, it accepts any instance of
    /// AbstractProductA as an argument.
    /// 此变体产品 B2 只能与变体产品 A2 一起正常工作。
    /// 然而，它接受 AbstractProductA 的任何实例作为参数。
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String {
        let result = collaborator.usefulFunctionA()
        return "The result of the B2 collaboration with the (\(result))"
    }
}

// MARK: 协议

/// 抽象工厂协议声明了一组返回不同抽象产品的方法。
/// 这些产品被称为一个系列，并由一个高级主题或概念相关联。
/// 一个家族的产品通常能够相互协作。
/// 一个产品系列可能有多个变体，但一个变体的产品与另一个变体的产品不兼容。
protocol AbstractFactory {
    func createFactoryA() -> AbstractProductA
    func createFactoryB() -> AbstractProductB
}

// MARK: 具体对象

/// 具体工厂生产属于单一变体的一系列产品。
/// 工厂保证产生的产品是兼容的。
/// 请注意，具体工厂方法的签名返回一个抽象产品，而在方法内部实例化了一个具体产品。
class ConcreteFactory1: AbstractFactory {
    func createFactoryA() -> AbstractProductA {
        return ConcreteProductA1()
    }
    
    func createFactoryB() -> AbstractProductB {
        return ConcreteProductB1()
    }
}

/// 每个具体工厂都有一个对应的产品变体。
class ConcreteFactory2: AbstractFactory {
    func createFactoryA() -> AbstractProductA {
        return ConcreteProductA2()
    }
    
    func createFactoryB() -> AbstractProductB {
        return ConcreteProductB2()
    }
}

// MARK: 调用
/// 客户端代码只能通过抽象类型来处理工厂和产品：AbstractFactory 和 AbstractProduct。
/// 这使您可以将任何工厂或产品子类传递给客户端代码而不会破坏它。
class Client {
    
    /// ...
    static func someClientCode(factory: AbstractFactory) {
        let productA = factory.createFactoryA()
        let productB = factory.createFactoryB()
        
        print(productB.usefulFunctionB())
        print(productB.anotherUsefulFunctionB(collaborator: productA))
    }
    /// ...
}
