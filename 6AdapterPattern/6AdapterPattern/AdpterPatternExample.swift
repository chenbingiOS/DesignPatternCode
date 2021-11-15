//
//  AdpterPatternExample.swift
//  6AdapterPattern
//
//  Created by mtAdmin on 2021/11/15.
//

import Foundation
import UIKit

/// Adapter Design Pattern
///
/// Intent: Convert the interface of a class into the interface clients expect.
/// Adapter lets classes work together that couldn't work otherwise because of
/// incompatible interfaces.
/// 适配器设计模式
///
/// 意图：将类的接口转换为客户期望的接口。
/// 适配器让那些因为接口不兼容而无法工作的类一起工作。

protocol AuthService {
    func presentAuthFlow(from viewController: UIViewController)
}

class FacebookAuthSDK {
    func presentAuthFlow(from viewController: UIViewController) {
        /// Call SDK methods and pass a view controller
        /// 调用 SDK 方法并传递一个视图控制器
        print("Facebook WebView has been shown.")
    }
}

class TwitterAuthSDK {
    func startAuthorization(with viewController: UIViewController) {
        /// Call SDK methods and pass a view controller
        /// 调用 SDK 方法并传递一个视图控制器
        print("The Adapter is called! Redirecting to the original method...")
    }
}

extension TwitterAuthSDK: AuthService {
    /// This is an adapter
    ///
    /// Yeah, we are able to not create another class and just extend an
    /// existing one
    /// 这是一个适配器
    ///
    /// 是的，我们可以不创建另一个类而只扩展一个现有的类
    func presentAuthFlow(from viewController: UIViewController) {
        print("The Adapter is called! Redirecting to the original method...")
        self.startAuthorization(with: viewController)
    }
}

extension FacebookAuthSDK: AuthService {
    /// This extension just tells a compiler that both SDKs have the same
    /// interface.
    /// 这个扩展只是告诉编译器两个 SDK 有相同的接口。
}
