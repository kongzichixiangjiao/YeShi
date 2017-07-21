//
//  YYAlertTextView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/10.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import Foundation

protocol YYAlertViewTextPotocol {
    var textLabel: UILabel { set get }
    func showView(text: String)
}

extension UIView: YYAlertViewTextPotocol {
    var textLabel: UILabel {
        get {
            guard let textLabel: UILabel = objc_getAssociatedObject(self, &YYAlertKey.kAlertTextLabel) as? UILabel else {
                let v = UILabel()
                v.numberOfLines = 0
                v.textAlignment = .center
                v.font = UIFont.systemFont(ofSize: 14)
                v.textColor = UIColor.white
                v.backgroundColor = UIColor.clear
                
                objc_setAssociatedObject(self, &YYAlertKey.kAlertTextLabel, v, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return v
            }
            return textLabel
        }
        set {
            
        }
    }
    
    var textToastView: UIView {
        get {
            guard let toastView: UIView = objc_getAssociatedObject(self, &YYAlertKey.kTextToastView) as? UIView else {
                let toastView = UIView()
                toastView.frame = CGRect(origin: (UIApplication.shared.keyWindow?.center)!, size: CGSize(width: 80, height: 80))
                toastView.backgroundColor = UIColor.darkGray
                toastView.alpha = 0.85
                toastView.layer.cornerRadius = 10
                
                toastView.center = self.alertWhiteWindow.center
                objc_setAssociatedObject(self, &YYAlertKey.kTextToastView, toastView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return toastView
            }
            return toastView
        }
        set {
            
        }
    }
    
    func heightWith(text: String, fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: text).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }
    
    func showView(text: String) {
        self.textLabel.text = text
        let w: CGFloat = UIScreen.main.bounds.width * 0.4
        let h = self.heightWith(text: text, fontSize: self.textLabel.font.pointSize, width: w)
        self.textToastView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: w + 40, height: h + 40))
        self.textToastView.center = self.alertWhiteWindow.center
        self.textLabel.frame = CGRect(origin: self.textToastView.frame.origin, size: CGSize(width: w, height: h))
        self.textLabel.center = self.alertWhiteWindow.center
        
        showAnimation(view: self.textToastView, isWhiteWindow: true)
        showAnimation(view: self.textLabel, isWhiteWindow: true)
    }
    
    func hideTextView() {
        ga_dissmissWhiteWindow()

        objc_setAssociatedObject(self, &YYAlertKey.kTextToastView, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &YYAlertKey.kAlertTextLabel, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
}
