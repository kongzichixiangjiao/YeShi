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
    
    let bW: CGFloat = 200
    let bH: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
        hx_login()
 
    }
    
    func initViews() {
        let register = UIButton()
        register.frame = CGRect(x: 0, y: 0, width: bW, height: bH)
        register.setTitle("register", for: .normal)
        register.backgroundColor = UIColor.lightGray
        register.addTarget(self, action: #selector(register(sender:)), for: .touchUpInside)
        self.view.addSubview(register)
        
        let login = UIButton()
        login.frame = CGRect(x: 100, y: 100, width: bW, height: bH)
        login.setTitle("login", for: .normal)
        login.backgroundColor = UIColor.lightGray
        login.addTarget(self, action: #selector(login(sender:)), for: .touchUpInside)
        self.view.addSubview(login)
        
        let logout = UIButton()
        logout.frame = CGRect(x: 100, y: 300, width: bW, height: bH)
        logout.setTitle("logout", for: .normal)
        logout.backgroundColor = UIColor.orange
        logout.addTarget(self, action: #selector(logout(sender:)), for: .touchUpInside)
        self.view.addSubview(logout)
        
        let createchatgroup = UIButton()
        createchatgroup.frame = CGRect(x: 100, y: 400, width: bW, height: bH)
        createchatgroup.setTitle("createchatgroup", for: .normal)
        createchatgroup.backgroundColor = UIColor.orange
        createchatgroup.addTarget(self, action: #selector(createchatgroup(sender:)), for: .touchUpInside)
        self.view.addSubview(createchatgroup)
        
        let addchatgroup = UIButton()
        addchatgroup.frame = CGRect(x: 100, y: 300, width: bW, height: bH)
        addchatgroup.setTitle("addchatgroup", for: .normal)
        addchatgroup.backgroundColor = UIColor.orange
        addchatgroup.addTarget(self, action: #selector(addchatgroup(sender:)), for: .touchUpInside)
        self.view.addSubview(addchatgroup)
        
        
        let groupList = UIButton()
        groupList.frame = CGRect(x: 100, y: 350, width: bW, height: bH)
        groupList.setTitle("groupList", for: .normal)
        groupList.backgroundColor = UIColor.orange
        groupList.addTarget(self, action: #selector(groupList(sender:)), for: .touchUpInside)
        self.view.addSubview(groupList)
    }
    
    func groupList(sender: UIButton) {
        hx_groupList()
    }
    
    func register(sender: UIButton) {
        hx_register()
    }
    
    func login(sender: UIButton) {
        hx_login()
    }
    
    func logout(sender: UIButton) {
        hx_logout()
    }
    
    func createchatgroup(sender: UIButton) {
        hx_createChatgroup()
    }
    
    func addchatgroup(sender: UIButton) {
        hx_addChatgroup()
    }
    
    
    func hx_groupList() {
        /*
        EMClient.shared().groupManager.getPublicGroupsFromServer(withCursor: nil, pageSize: 20) { (result, error) in
            if let e = error {
                print("error: \(e)")
                return
            }
            print(result?.list ?? "")
        }
        */
        EMClient.shared().groupManager.getJoinedGroupsFromServer(withPage: 1, pageSize: 10) { (result, error) in
            print("result: \(String(describing: result)), error: \(String(describing: error))")
        }
    }
    
    func hx_addChatgroup() {
        print("hx_addChatgroup")
        var error: EMError? = EMError()
        EMClient.shared().groupManager.addOccupants([HuanXin.userId, "houjianan101"], toGroup: HuanXin.groupId, welcomeMessage: "欢迎光临", error: &error)
        hx_enterIntoChatgroup()
        
    }
    
    func hx_register() {
        print("hx_register")
        EMClient.shared().register(withUsername: HuanXin.userId, password: HuanXin.password) { (message, error) in
            if let e = error {
                print("message: \(String(describing: message)), error: \(String(describing: e.errorDescription))")
                return
            }
            print("注册成功")
        }
    }
    
    func hx_createChatgroup() {
        print("hx_createChatgroup")
        let setting = EMGroupOptions()
        setting.maxUsersCount = 500
        setting.style = EMGroupStylePublicOpenJoin
        var error: EMError? = EMError()
        let group = EMClient.shared().groupManager.createGroup(withSubject: "我是测试subject", description: "YueYe测试群聊001", invitees: ["houjianan101_iphone", "houjianan101"], message: "邀请您加入群组，来吧！", setting: setting, error: &error)
        if let e = error {
            print("创建成功 -- groupId: \(String(describing: group?.groupId)), error: \(e.errorDescription)")
            return
        }
        HuanXin.groupId = group!.groupId
    }
    
    func hx_enterIntoChatgroup() {
        print("hx_enterIntoChatgroup id: \(HuanXin.groupId)")
        let chatController = EaseMessageViewController(conversationChatter: HuanXin.groupId, conversationType: EMConversationType.init(2))
        self.push(vc: chatController!)
    }
    
    func hx_login() {
        print("hx_login")
        EMClient.shared().login(withUsername: HuanXin.userId, password: HuanXin.password) {
            [weak self] userName, error in
            if let _ = self {
                if let e = error {
                    print("userName: \(String(describing: userName)), error: \(String(describing: e.errorDescription))")
                    return
                }
                print("登录成功")
            }
        }
    }
    
    func hx_logout() {
        print("hx_logout")
        guard let error = EMClient.shared().logout(true) else {
            print("退出成功")
            return
        }
        print("code: \(error.code)", " ", "errorDescription: \(error.errorDescription)")
    }
    
}

extension YYIMViewcontroller: EMGroupManagerDelegate {
    func didJoin(_ aGroup: EMGroup!, inviter aInviter: String!, message aMessage: String!) {
        self.view.showView(text: "groupId: \(aGroup.groupId), inviter: \(aInviter), message: \(aMessage)")
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
