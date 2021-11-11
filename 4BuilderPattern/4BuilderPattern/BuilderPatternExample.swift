//
//  BuilderPatternExample.swift
//  4BuilderPattern
//
//  Created by mtAdmin on 2021/11/11.
//

import Foundation

class BaseQueryBuilder<Model: DomainModel> {
    typealias Predicate = (Model) -> (Bool)
    
    func limit(_ limit: Int) -> BaseQueryBuilder<Model> {
        return self
    }
    
    func filter(_ predicate: @escaping Predicate) -> BaseQueryBuilder<Model> {
        return self
    }
    
    func fetch() -> [Model] {
        preconditionFailure("Should be overridden in subclasses.")
    }
}

class RealmQueryBuilder<Model: DomainModel>: BaseQueryBuilder<Model> {
    enum Query {
        case filter(Predicate)
        case limit(Int)
    }
    
    fileprivate var operations = [Query]()
    
    override func limit(_ limit: Int) -> BaseQueryBuilder<Model> {
        operations.append(Query.limit(limit))
        return self
    }
    
    override func filter(_ predicate: @escaping Predicate) -> BaseQueryBuilder<Model> {
        operations.append(Query.filter(predicate))
        return self
    }
    
    override func fetch() -> [Model] {
        print("RealmQueryBuilder: Initializing RealmProvider with \(operations.count) operations:")
        return RealmProvider().fetch(operations)
    }
}

class CoreDataQueryBuilder<Model: DomainModel>: BaseQueryBuilder<Model> {
    enum Query {
        case filter(Predicate)
        case limit(Int)
        case includesPropertyValues(Bool)
    }
    
    fileprivate var operations = [Query]()
    
    override func limit(_ limit: Int) -> BaseQueryBuilder<Model> {
        operations.append(Query.limit(limit))
        return self
    }
    
    override func filter(_ predicate: @escaping BaseQueryBuilder<Model>.Predicate) -> BaseQueryBuilder<Model> {
        operations.append(Query.filter(predicate))
        return self
    }
    
    func includesPropertyValues(_ toggle: Bool) -> CoreDataQueryBuilder<Model> {
        operations.append(Query.includesPropertyValues(toggle))
        return self
    }
    
    override func fetch() -> [Model] {
        print("CoreDataQueryBuilder: Initializing CoreDataProvider with \(operations.count) operations")
        return CoreDataProvider().fetch(operations)
    }
}

/// Data Providers contain a logic how to fetch models. Builders accumulate
/// operations and then update providers to fetch the data.
/// 数据提供者包含如何获取模型的逻辑。
/// 构建器累积操作，然后更新提供程序以获取数据。
class RealmProvider {
    func fetch<Model: DomainModel>(_ operations: [RealmQueryBuilder<Model>.Query]) -> [Model] {
        print("RealmProvider: Retrieving data from Realm...")
        
        for item in operations {
            switch item {
            case .filter(_):
                print("RealmProvider: excuting the 'filter' operation.")
                /// Use Realm instance to filter results.
                /// 使用 Realm 实例过滤结果。
                break
            case .limit(_):
                print("RealmProvider: excuting the 'limit' operation.")
                /// Use Realm instance to limit results.
                /// 使用 Realm 实例来限制结果。
                break
            }
        }
        /// Return results from Realm
        /// 从 Realm 返回结果
        return []
    }
}

class CoreDataProvider {
    func fetch<Model: DomainModel>(_ operations: [CoreDataQueryBuilder<Model>.Query]) -> [Model] {
        /// Create a NSFetchRequest
        /// 创建一个 NSFetchRequest
        print("CoreDataProvider: Retrieving data from CoreData...")
        
        for item in operations {
            switch item {
            case .filter(_):
                print("CoreDataProvider: exceuting the 'filter' operation.")
                /// Set a 'predicate' for a NSFetchRequest.
                /// 为 NSFetchRequest 设置一个“谓词”。
                break
            case .limit(_):
                print("CoreDataProvider: exceuting the 'limit' operation.")
                /// Set a 'fetchLimit' for a NSFetchRequest.
                /// 为 NSFetchRequest 设置一个“fetchLimit”。
                break
            case .includesPropertyValues:
                print("CoreDataProvider: executing the 'includesPropertyValues' operation.")
                /// Set an 'includesPropertyValues' for a NSFetchRequest.
                /// 为 NSFetchRequest 设置一个“includesPropertyValues”。
                break
            }
        }
        /// Execute a NSFetchRequest and return results.
        /// 执行一个 NSFetchRequest 并返回结果。
        return []
    }
}

protocol DomainModel {
    /// The protocol groups domain models to the common interface
    /// 协议将域模型分组到公共接口
}

struct User: DomainModel {
    let id: Int
    let age: Int
    let email: String
}
