//
//  YYIMViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/11.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUI

class YYIMViewcontroller: YYBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        hx_login()
    }
    
    func initViews() {
        let login = UIButton()
        login.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        login.setTitle("login", for: .normal)
        login.backgroundColor = UIColor.lightGray
        login.addTarget(self, action: #selector(login(sender:)), for: .touchUpInside)
        self.view.addSubview(login)
        
        let logout = UIButton()
        logout.frame = CGRect(x: 100, y: 300, width: 100, height: 100)
        logout.setTitle("login", for: .normal)
        logout.backgroundColor = UIColor.orange
        logout.addTarget(self, action: #selector(logout(sender:)), for: .touchUpInside)
        self.view.addSubview(logout)
        
        let chatgroup = UIButton()
        chatgroup.frame = CGRect(x: 100, y: 400, width: 100, height: 100)
        chatgroup.setTitle("chatgroup", for: .normal)
        chatgroup.backgroundColor = UIColor.orange
        chatgroup.addTarget(self, action: #selector(chatgroup(sender:)), for: .touchUpInside)
        self.view.addSubview(chatgroup)
    }
    
    func login(sender: UIButton) {
        hx_login()
    }
    
    func logout(sender: UIButton) {
        hx_logout()
    }
    
    func chatgroup(sender: UIButton) {
        hx_chatgroup()
    }
    
    func hx_enterIntoChatgroup() {
        let chatController = EaseMessageViewController(conversationChatter: "9020", conversationType: EMConversationType.init(2))
        self.push(vc: chatController!)
    }
    
    func hx_login() {
        /*
        let isAutoLogin = EMClient.shared().options.isAutoLogin;
        if (!isAutoLogin) {
            guard let error = EMClient.shared().login(withUsername: HuanXin.userId, password: HuanXin.password) else {
                print("登录成功")
                return
            }
            print("code: \(error.code)", " ", "errorDescription: \(error.errorDescription)")
        }
 */
        EMClient.shared().login(withUsername: HuanXin.userId, token: HuanXin.password) { (userName, error) in
            print("userName: \(String(describing: userName)), error: \(String(describing: error))")
        }
    }
    
    func hx_logout() {
            guard let error = EMClient.shared().logout(true) else {
                print("退出成功")
                return
            }
            print("code: \(error.code)", " ", "errorDescription: \(error.errorDescription)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        hx_logout()
    }
}

extension YYIMViewcontroller: EMClientDelegate {
    // 自动登录
    func autoLoginDidCompleteWithError(_ aError: EMError!) {
        print("code: \(aError.code)", " ", "errorDescription: \(aError.errorDescription)")
    }
    // 重连
    func connectionStateDidChange(_ aConnectionState: EMConnectionState) {
        print("aConnectionState: \(aConnectionState)")
    }
    
    /*!
     *  当前登录账号在其它设备登录时会接收到该回调
     */
    func userAccountDidLoginFromOtherDevice() {
        print("当前登录账号在其它设备登录时会接收到该回调")
    }
    
    /*!
     *  当前登录账号已经被从服务器端删除时会收到该回调
     */
    func userAccountDidRemoveFromServer() {
        print("当前登录账号已经被从服务器端删除时会收到该回调")
    }
}
