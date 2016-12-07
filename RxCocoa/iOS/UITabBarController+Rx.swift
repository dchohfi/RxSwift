//
//  UITabBarController+Rx.swift
//  RxCocoa
//
//  Created by Yusuke Kita on 2016/12/07.
//  Copyright © 2016 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation
import UIKit
    
#if !RX_NO_MODULE
import RxSwift
#endif
    
/**
 iOS only
 */
#if os(iOS)
extension Reactive where Base: UITabBarController {
    
    /// Reactive wrapper for `delegate` message `tabBarController:willBeginCustomizing:`.
    public var willBeginCustomizing: ControlEvent<[UIViewController]> {
        let source = delegate.methodInvoked(#selector(UITabBarControllerDelegate.tabBarController(_:willBeginCustomizing:)))
            .map { a in
                return try castOrThrow([UIViewController].self, a[1])
        }
        
        return ControlEvent(events: source)
    }
    
    /// Reactive wrapper for `delegate` message `tabBarController:willEndCustomizing:changed:`.
    public var willEndCustomizing: ControlEvent<([UIViewController], Bool)> {
        let source = delegate.methodInvoked(#selector(UITabBarControllerDelegate.tabBarController(_:willEndCustomizing:changed:)))
            .map { (a: [Any]) -> (([UIViewController], Bool)) in
                let viewControllers = try castOrThrow([UIViewController].self, a[1])
                let changed = try castOrThrow(Bool.self, a[2])
                return (viewControllers, changed)
        }
        
        return ControlEvent(events: source)
    }
    
    /// Reactive wrapper for `delegate` message `tabBarController:didEndCustomizing:changed:`.
    public var didEndCustomizing: ControlEvent<([UIViewController], Bool)> {
        let source = delegate.methodInvoked(#selector(UITabBarControllerDelegate.tabBarController(_:didEndCustomizing:changed:)))
            .map { (a: [Any]) -> (([UIViewController], Bool)) in
                let viewControllers = try castOrThrow([UIViewController].self, a[1])
                let changed = try castOrThrow(Bool.self, a[2])
                return (viewControllers, changed)
        }
        
        return ControlEvent(events: source)
    }
}
#endif
    
/**
 iOS and tvOS
 */
extension UITabBarController {
    
    /// Factory method that enables subclasses to implement their own `delegate`.
    ///
    /// - returns: Instance of delegate proxy that wraps `delegate`.
    public func createRxDelegateProxy() -> RxTabBarControllerDelegateProxy {
        return RxTabBarControllerDelegateProxy(parentObject: self)
    }
    
}
    
extension Reactive where Base: UITabBarController {
    /// Reactive wrapper for `delegate`.
    ///
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var delegate: DelegateProxy {
        return RxTabBarControllerDelegateProxy.proxyForObject(base)
    }
    
    /// Reactive wrapper for `delegate` message `tabBarController:didSelect:`.
    public var didSelect: ControlEvent<UIViewController> {
        let source = delegate.methodInvoked(#selector(UITabBarControllerDelegate.tabBarController(_:didSelect:)))
            .map { a in
                return try castOrThrow(UIViewController.self, a[1])
        }
        
        return ControlEvent(events: source)
    }
}

#endif
