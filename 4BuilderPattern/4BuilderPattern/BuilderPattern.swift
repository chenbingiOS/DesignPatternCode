//
//  BuilderPattern.swift
//  4BuilderPattern
//
//  Created by mtAdmin on 2021/11/11.
//

import Foundation

/// The Builder interface specifies methods for creating the different parts of the Product objects.
/// Builder 接口指定了用于创建 Product 对象不同部分的方法。
protocol Builder {
    func producePartA()
    func producePartB()
    func producePartC()
}

/// The Concrete Builder classes follow the Builder interface and provide
/// specific implementations of the building steps. Your program may have
/// several variations of Builders, implemented differently.
/// Concrete Builder 类遵循 Builder 接口并提供构建步骤的具体实现。
/// 您的程序可能有几种不同的构建器变体，以不同的方式实现。
class ConcreteBuilderA: Builder {
    /// A fresh builder instance should contain a blank product object, which is
    /// used in further assembly.
    /// 一个新的构建器实例应该包含一个空白的产品对象，用于进一步的组装。
    private var product = Product1()
    
    func reset() {
        product = Product1()
    }
    
    /// All production steps work with the same product instance.
    /// 所有生产步骤都使用相同的产品实例。
    func producePartA() {
        product.add(part: "PartA")
    }
    
    func producePartB() {
        product.add(part: "PartB")
    }
    
    func producePartC() {
        product.add(part: "PartC")
    }
    
    /// Concrete Builders are supposed to provide their own methods for
    /// retrieving results. That's because various types of builders may create
    /// entirely different products that don't follow the same interface.
    /// Therefore, such methods cannot be declared in the base Builder interface
    /// (at least in a statically typed programming language).
    ///
    /// Usually, after returning the end result to the client, a builder
    /// instance is expected to be ready to start producing another product.
    /// That's why it's a usual practice to call the reset method at the end of
    /// the `getProduct` method body. However, this behavior is not mandatory,
    /// and you can make your builders wait for an explicit reset call from the
    /// client code before disposing of the previous result.
    /// 具体构建器应该提供自己的方法来检索结果。
    /// 这是因为不同类型的构建器可能会创建完全不同的产品，它们不遵循相同的界面。
    /// 因此，不能在基本 Builder 接口中声明此类方法（至少在静态类型的编程语言中）。
    ///
    /// 通常，在将最终结果返回给客户端后，预计构建器实例已准备好开始生产另一个产品。
    /// 这就是为什么通常的做法是在`getProduct`方法体的末尾调用reset方法。
    /// 但是，此行为不是强制性的，您可以让您的构建器在处理之前的结果之前等待来自客户端代码的显式重置调用。
    func retrieveProduct() -> Product1 {
        let result = self.product
        reset()
        return result
    }
}

/// The Director is only responsible for executing the building steps in a
/// particular sequence. It is helpful when producing products according to a
/// specific order or configuration. Strictly speaking, the Director class is
/// optional, since the client can control builders directly.
/// Director 只负责按特定顺序执行构建步骤。
/// 根据特定订单或配置生产产品时很有帮助。
/// 严格来说，Director 类是可选的，因为客户端可以直接控制构建器。
class Director {
    private var builder: Builder?
    
    /// The Director works with any builder instance that the client code passes
    /// to it. This way, the client code may alter the final type of the newly
    /// assembled product.
    /// Director 使用客户端代码传递给它的任何构建器实例。
    /// 这样，客户代码可能会改变新组装产品的最终类型。
    func update(builder: Builder) {
        self.builder = builder
    }
    
    /// The Director can construct several product variations using the same
    /// building steps.
    /// Director 可以使用相同的构建步骤构建多个产品变体。
    func buildMinimalViableProduct() {
        builder?.producePartA()
    }
    
    func buildFullFeaturedProduct() {
        builder?.producePartA()
        builder?.producePartB()
        builder?.producePartC()
    }
}

/// It makes sense to use the Builder pattern only when your products are quite
/// complex and require extensive configuration.
///
/// Unlike in other creational patterns, different concrete builders can produce
/// unrelated products. In other words, results of various builders may not
/// always follow the same interface.
///
/// 只有当您的产品非常复杂并且需要大量配置时，才使用构建器模式才有意义。
///
/// 与其他创建模式不同，不同的具体构建者可以生产不相关的产品。
/// 换句话说，不同构建器的结果可能并不总是遵循相同的界面。
class Product1 {
    private var parts = [String]()
    
    func add(part: String) {
        parts.append(part)
    }
    
    func listParts() -> String {
        return "Product parts: " + parts.joined(separator: ", ") + "\n"
    }
}

/// The client code creates a builder object, passes it to the director and then
/// initiates the construction process. The end result is retrieved from the
/// builder object.
/// 客户端代码创建一个builder对象，将其传递给director，然后启动构建过程。
/// 从构建器对象中检索最终结果。
class Client {
    static func someClientCode(director: Director) {
        let builder = ConcreteBuilderA()
        director.update(builder: builder)
        
        print("Standard basic product:")
        director.buildMinimalViableProduct()
        print(builder.retrieveProduct().listParts())
        
        print("Standard full featured product:")
        director.buildFullFeaturedProduct()
        print(builder.retrieveProduct().listParts())
        
        // Remember, the Builder pattern can be used without a Director class.
        // 请记住，Builder 模式可以在没有 Director 类的情况下使用。
        print("Custom product:")
        builder.producePartA()
        builder.producePartC()
        print(builder.retrieveProduct().listParts())
    }
}
