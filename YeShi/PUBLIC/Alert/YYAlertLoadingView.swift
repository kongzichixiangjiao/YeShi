//
//  YYAlertView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/6.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit


// MARK: loading
protocol LoadingProtocol {
    var toastView: UIView { set get}
    var activity: UIActivityIndicatorView { set get }
}

extension UIView: LoadingProtocol {
    var activity: UIActivityIndicatorView {
        get {
            guard let activity: UIActivityIndicatorView = objc_getAssociatedObject(self, &YYAlertKey.kActivity) as? UIActivityIndicatorView else {
                let activity = UIActivityIndicatorView(activityIndicatorStyle: .white)
                activity.startAnimating()
                activity.center = self.alertWindow.center
                
                objc_setAssociatedObject(self, &YYAlertKey.kActivity, activity, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return activity
            }
            return activity
        }
        set {
            
        }
    }
    var toastView: UIView {
        get {
            guard let toastView: UIView = objc_getAssociatedObject(self, &YYAlertKey.kToastView) as? UIView else {
                let toastView = UIView()
                toastView.frame = CGRect(origin: (UIApplication.shared.keyWindow?.center)!, size: CGSize(width: 80, height: 80))
                toastView.backgroundColor = UIColor.darkGray
                toastView.alpha = 0.85
                toastView.layer.cornerRadius = 10
                
                toastView.center = self.alertWindow.center
                objc_setAssociatedObject(self, &YYAlertKey.kToastView, toastView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return toastView
            }
            return toastView
        }
        set {
            
        }
    }
    
    func showLoadingView() {
        self.showAnimation(view: self.toastView)
        self.showAnimation(view: self.activity)
    }
    
    func hideLoadingView() {
        hideAnimation(view: self.toastView)
    }
}


