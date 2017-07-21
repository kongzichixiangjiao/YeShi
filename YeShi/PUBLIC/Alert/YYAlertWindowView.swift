//
//  YYWindow.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/14.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYWindow: UIWindow {
    
}

// MARK: window
protocol WindowProtocol {
    var alertWindow: YYWindow { set get }
    
    var alertWhiteWindow: YYWindow { set get }
}

extension UIView: WindowProtocol {
    var alertWhiteWindow: YYWindow {
        get {
            guard let window: YYWindow = objc_getAssociatedObject(self, &YYAlertKey.kAlertWhiteWindow) as? YYWindow else {
                let alertWindow = YYWindow(frame: UIScreen.main.bounds)
                alertWindow.windowLevel = UIWindowLevelAlert
                alertWindow.backgroundColor = UIColor.clear
                alertWindow.becomeKey()
                alertWindow.makeKeyAndVisible()
                alertWindow.isHidden = false
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapWhiteWindow(sender:)))
                alertWindow.addGestureRecognizer(tap)
                
                objc_setAssociatedObject(self, &YYAlertKey.kAlertWhiteWindow, alertWindow, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return alertWindow
            }
            return window
        }
        set {
            self.alertWhiteWindow = newValue
        }
    }

    var alertWindow: YYWindow {
        get {
            guard let window: YYWindow = objc_getAssociatedObject(self, &YYAlertKey.kAlertWindow) as? YYWindow else {
                let alertWindow = YYWindow(frame: UIScreen.main.bounds)
                alertWindow.windowLevel = UIWindowLevelAlert
                alertWindow.backgroundColor = UIColor.clear
                alertWindow.becomeKey()
                alertWindow.makeKeyAndVisible()
                alertWindow.isHidden = false
                
                let v = UIView()
                v.bounds = UIScreen.main.bounds
                v.center = alertWindow.center
                v.alpha = 0.25
                v.backgroundColor = UIColor.black
                alertWindow.addSubview(v)
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapBackView(sender:)))
                alertWindow.addGestureRecognizer(tap)
                
                objc_setAssociatedObject(self, &YYAlertKey.kAlertWindow, alertWindow, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return alertWindow
            }
            return window
        }
        set {
            self.alertWindow = newValue
        }
    }
    
    func tapWhiteWindow(sender: UITapGestureRecognizer) {
        ga_dissmissWhiteWindow()
    }
    
    public func ga_dismissWindow() {
        self.alertWindow.resignKey()
        self.alertWindow.isHidden = true
        
        objc_setAssociatedObject(self, &YYAlertKey.kAlertWindow, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        objc_setAssociatedObject(self, &YYAlertKey.kAlertType, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    public func ga_dissmissWhiteWindow() {
        self.alertWhiteWindow.resignKey()
        self.alertWhiteWindow.isHidden = true
        
        objc_setAssociatedObject(self, &YYAlertKey.kAlertWhiteWindow, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        objc_setAssociatedObject(self, &YYAlertKey.kAlertType, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    public func ga_hideOtherView() {
        objc_setAssociatedObject(self, &YYAlertKey.kAlertWhiteWindow, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        switch self.type {
        case .normal:
            hideLoadingView()
            break
        case .loading:
            hideLoadingView()
            break
        case .text:
            hideTextView()
            break
        case .selected:
            hideSelectedLoading()
            break
        case .birthday:
            hideBirthdayView()
            break
        }
    }
}
