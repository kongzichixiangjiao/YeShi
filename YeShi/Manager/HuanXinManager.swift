//
//  HuanXinManager.swift
//  YeShi
//
//  Created by 侯佳男 on 2017/7/21.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation
import EaseUILite

class HXManager {
    static let manager = HXManager()
    
    class var share: HXManager {
        return manager
    }
    
    typealias FinishedHandler = (_: Bool) -> ()
    
    // MARK: 创建群组
    func hx_createChatGroup(isGroupJurisdiction: Bool, isMemberAddJurisdiction: Bool, subject: String, description: String, message: String, maxUsersCount: Int = 500, handler: FinishedHandler) {
        let setting = EMGroupOptions()
        setting.maxUsersCount = maxUsersCount
        
        var style: EMGroupStyle!
        // 公开群组
        if isGroupJurisdiction {
            if isMemberAddJurisdiction {
                // 随便加入
                style = EMGroupStylePublicOpenJoin
            } else {
                // Owner可以邀请用户加入; 非群成员用户发送入群申请，经Owner同意后才能入组
                style = EMGroupStylePublicJoinNeedApproval
            }
            // 私有群组
        } else {
            if isMemberAddJurisdiction {
                // 允许群成员邀请其他
                style = EMGroupStylePublicOpenJoin
            } else {
                // 不允许群成员邀请其他
                style = EMGroupStylePublicJoinNeedApproval
            }
        }
        setting.style = style
        setting.isInviteNeedConfirm = false
        var error: EMError? = EMError()
        let group = EMClient.shared().groupManager.createGroup(withSubject: subject, description: description, invitees: nil, message: message, setting: setting, error: &error)
        if let e = error {
            print("error: \(e)")
            handler(false)
        }
        print("group: \(String(describing: group))")
        handler(true)
    }
    
    //MARK: 注册
    class func hx_register(handler: @escaping FinishedHandler) {
        guard let error = EMClient.shared().register(withUsername: HuanXin.userId, password: HuanXin.password) else {
            handler(true)
            return
        }
        handler(false)
        print("code: \(error.code)", " ", "errorDescription: \(error.errorDescription)")
    }
    
    //MARK: 登录
    class func hx_login(handler: @escaping FinishedHandler)  {
        EMClient.shared().login(withUsername: HuanXin.userId, password: HuanXin.password, completion: { (string, error) in
            if let e = error {
                print("error: \(e.debugDescription)")
                handler(false)
            }
            handler(true)
        })
    }
}
