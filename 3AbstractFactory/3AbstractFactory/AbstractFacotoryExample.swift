//
//  AbstractFacotoryExample.swift
//  3AbstractFactory
//
//  Created by mtAdmin on 2021/11/9.
//

import Foundation
import UIKit


enum AuthType {
    case login
    case signUp
}

// MARK: 抽象产品

protocol AuthView {
    typealias AuthAction = (AuthType) -> ()
    
    var contentView: UIView { get }
    var authHandler: AuthAction? { get set }
    
    var descripthion: String { get }
}

class StudentSignUpView: UIView, AuthView {
    
    private class StudentSignUpContentView: UIView {
        /// This view contains a number of features available only during a
        /// STUDENT authorization.
        /// 此视图包含许多仅在学生授权期间可用的功能。
    }
    
    var contentView: UIView = StudentSignUpContentView()
    
    /// The handler will be connected for actions of buttons of this view.
    /// 处理程序将连接此视图的按钮的操作。
    var authHandler: AuthAction?
    
    var descripthion: String {
        return "Student-SignUp-View"
    }
}

class StudentLoginView: UIView, AuthView {
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let signUpButton = UIButton()
    
    var contentView: UIView {
        return self
    }
    
    /// The handler will be connected for actions of buttons of this view.
    var authHandler: AuthAction?
    
    var descripthion: String {
        return "Student-Login-View"
    }
}

class TeacherSignUpView: UIView, AuthView {
    
    private class TeacherSignUpContentView: UIView {
        /// This view contains a number of features available only during a
        /// TEACHER authorization.
        /// 此视图包含许多仅在教师授权期间可用的功能。
    }
    
    var contentView: UIView = TeacherSignUpContentView()
    
    /// The handler will be connected for actions of buttons of this view.
    var authHandler: AuthAction?
    
    var descripthion: String {
        return "Teacher-SignUp-View"
    }
}

class TeacherLoginView: UIView, AuthView {
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let signUpButton = UIButton()
    private let forgotPasswordButton = UIButton()
    
    var contentView: UIView {
        return self
    }
    
    /// The handler will be connected for actions of buttons of this view.
    var authHandler: AuthAction?
    
    var descripthion: String {
        return "Teacher-Login-View"
    }
}

class AuthViewController: UIViewController {
    fileprivate var contentView: AuthView
    
    init(contentView: AuthView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

class StudentAuthViewController: AuthViewController {
    /// Student-oriented features
    /// 面向学生的功能
}

class TeacherAuthViewController: AuthViewController {
    /// Teacher-oriented features
    /// 面向教师的功能
}

// MARK: 抽象工厂

protocol AuthViewFactory {
    static func authView(type: AuthType) -> AuthView
    static func authController(for type: AuthType) -> AuthViewController
}

class StudentAuthViewFactory: AuthViewFactory {
    static func authView(type: AuthType) -> AuthView {
        print("Student View has been created")
        switch type {
        case .login:
            return StudentLoginView()
        case .signUp:
            return StudentSignUpView()
        }
    }
    
    static func authController(for type: AuthType) -> AuthViewController {
        let controller = StudentAuthViewController(contentView: authView(type: type))
        print("Student View Controller has been created")
        return controller
    }
}

class TeacherAuthViewFactory: AuthViewFactory {
    static func authView(type: AuthType) -> AuthView {
        print("Teacher View has been created")
        switch type {
        case .login:
            return TeacherLoginView()
        case .signUp:
            return TeacherSignUpView()
        }
    }
    
    static func authController(for type: AuthType) -> AuthViewController {
        let controller = TeacherAuthViewController(contentView: authView(type: type))
        print("Teacher View Controller has been created")
        return controller
    }
}

class ClientCode {
    private var currentController: AuthViewController?
    
    private lazy var navigationController: UINavigationController = {
        guard let vc = currentController else {
            return UINavigationController()
        }
        return UINavigationController(rootViewController: vc)
    }()
    
    private let factoryType: AuthViewFactory.Type
    
    init(factoryType: AuthViewFactory.Type) {
        self.factoryType = factoryType
    }
    
    // MARK: - Presentation
    
    func presentLogin() {
        let controller = factoryType.authController(for: .login)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func presentSignUp() {
        let controller = factoryType.authController(for: .signUp)
        navigationController.pushViewController(controller, animated: true)
    }
    
    /// other methods...
}
