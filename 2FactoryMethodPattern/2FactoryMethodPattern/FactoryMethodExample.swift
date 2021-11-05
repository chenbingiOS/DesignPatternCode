//
//  FactoryMethodExample.swift
//  2FactoryMethodPattern
//
//  Created by mtAdmin on 2021/11/4.
//

import Foundation

// MARK: 协议提供方
// Projector 投影仪
protocol Projector {
    /// 抽象 Projector 接口
    var currentPage: Int { get }
    
    func present(info: String)
    
    func sync(with projector: Projector)
    
    func update(with page: Int)
}

extension Projector {
    /// 遵循 Projector 协议的对象都会默认实现 sync 方法
    func sync(with projector: Projector) {
        projector.update(with: currentPage)
    }
}

protocol ProjectorFactory {
    func createProjector() -> Projector
    
    func syncedProjector(with projector: Projector) -> Projector
}

extension ProjectorFactory {
    /// 默认实现
    func syncedProjector(with projector: Projector) -> Projector {
        /// 每个实例创建一个自己的 Projector
        let newProjector = createProjector()
        
        newProjector.sync(with: projector)
        
        return newProjector
    }
}

// MARK: 实现
class WifiProjector: Projector {
    var currentPage: Int = 0
    
    func present(info: String) {
        print("Info is present over Wifi: \(info)")
    }
    
    func update(with page: Int) {
        /// ... 通过 Wifi 连接滚动页面
        /// ...
        currentPage = page
    }
}

class BluetoothProjector: Projector {
    var currentPage: Int = 0
    
    func present(info: String) {
        print("Info is present over Bluetooth: \(info)")
    }
    
    func update(with page: Int) {
        /// ... 通过蓝牙连接滚动页面
        /// ...
        currentPage = page
    }
}

class WifiFactory: ProjectorFactory {
    func createProjector() -> Projector {
        return WifiProjector()
    }
}

class BluetoothFactory: ProjectorFactory {
    func createProjector() -> Projector {
        return BluetoothProjector()
    }
}

// MARK: 调用
class ClientCode {
    private var currentProjector: Projector?
    
    func present(info: String, with factory: ProjectorFactory) {
        /// 检查客户端代码是否已经存在...
        guard let projector = currentProjector else {
            /// 'currentProjector' 变量为空。
            /// 创建一个新的 Projector 并开始演示。
            let projector = factory.createProjector()
            projector.present(info: info)
            self.currentProjector = projector
            return
        }
        
        /// 客户端代码已经有一个 Projector。
        /// 让我们将旧 Projector 的页面与新 Projector 同步。
        self.currentProjector = factory.syncedProjector(with: projector)
        self.currentProjector?.present(info: info)
    }
}
