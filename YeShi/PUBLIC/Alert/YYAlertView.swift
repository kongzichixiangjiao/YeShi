//
//  YYAlertView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/15.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

struct YYAlertKey {
    
    static var kAlertType: UInt = 10006
    static var kToastView: UInt = 10007
    static var kLoadingView: UInt = 10008
    static var kActivity: UInt = 10009
    static var kAlertWindow: UInt = 10010
    static var kTableView: UInt = 10011
    static var kDidSelectedHandler: UInt = 10012
    static var kSelectedData: UInt = 10013
    static var kSelectedHeaderView: UInt = 10014
    static var kBirthdayView: UInt = 10015
    static var kAlertWhiteWindow: UInt = 10016
    static var kAlertTextLabel: UInt = 10017
    static var kTextToastView: UInt = 10018
}

enum YYAlertType: Int {
    case normal = 0, text = 1, birthday = 2, selected = 3, loading = 4
}

protocol AlertTypeProtocol {
    var type: YYAlertType { set get }
}

extension UIView: AlertTypeProtocol {
    var type: YYAlertType {
        get {
            guard let type = objc_getAssociatedObject(self, &YYAlertKey.kAlertType) else {
                return YYAlertType(rawValue: 0)!
            }
            return type as! YYAlertType
        }
        set {
            
        }
    }
    
    func ga_showView(text: String, deplay: Double = 0) {
        setup(type: .text)
        showView(text: text)
        if deplay != 0 {
            let queue = DispatchQueue.global(qos: .default)
            queue.asyncAfter(deadline: DispatchTime.now() + Double(Int64(deplay * 1000 * 1000000)) / Double(NSEC_PER_SEC), execute: {
                [weak self] in
                if let weakSelf = self {
                    weakSelf.ga_hideTextView()
                }
            })
        }
    }
    
    func ga_hideTextView() {
        hideTextView()
    }
    
    func ga_showBirthdayView(handler: @escaping DidSelectedHandler) {
        setup(type: .birthday)
        showBirthdayView(handler: handler)
    }
    
    func ga_hideBirthdayView() {
        hideBirthdayView()
    }
    
    // MARK: selected
    // MARK: loading
    func ga_showSelectedLoading(title: String = "请选择", data: [Any], handler: @escaping DidSelectedHandler) {
        setup(type: .selected)
        showSelectedLoading(title: title, data: data, handler)
    }
    
    public func ga_hideSelectedLoading() {
        hideSelectedLoading()
    }
    
    // MARK: loading
    public func ga_showLoading() {
        setup(type: .loading)
        showLoadingView()
    }
    
    public func ga_hideLoading() {
        hideLoadingView()
    }
    
    private func setup(type: YYAlertType) {
        objc_setAssociatedObject(self, &YYAlertKey.kAlertType, type, .OBJC_ASSOCIATION_ASSIGN)
    }
}
