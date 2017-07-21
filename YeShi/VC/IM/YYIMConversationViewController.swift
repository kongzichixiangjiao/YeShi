//
//  YYIMConversationViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/12.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUI

class YYIMConversationViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationView()
        for id in HuanXin.groupConversationIds {
            hx_createConversation(id: id, type: EMConversationTypeGroupChat)
        }
        for id in HuanXin.chatConversationIds {
            hx_createConversation(id: id, type: EMConversationTypeChat)
        }

        //注册消息回调
        EMClient.shared().chatManager.add(self, delegateQueue: nil)
        
        
        EMClient.shared().roomManager.joinChatroom(HuanXin.chatConversationIds[0]) { (room, error) in
            
        }
    }
    
    func initNavigationView() {
        self.myTitle = "群组"
        self.navigationView.setupRightButton(type: .normal)
    }
    
    func action(sender: UIButton) {
    
    }
    
    override func initTableView() {
        super.initTableView()
        isShowTabbar = true
        tableViewFrameType = .normal64
        registerNibWithIdentifier(YYConversationCell.identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func hx_createConversation(id: String, type: EMConversationType) {
        //EMConversationTypeChat            单聊会话
        //EMConversationTypeGroupChat       群聊会话
        //EMConversationTypeChatRoom        聊天室会话
        guard let conversation = EMClient.shared().chatManager.getConversation(id, type: type, createIfNotExist: true) else {
            self.view.showView(text: "会话创建失败")
            return
        }
        self.dataSource.append(conversation)
    }
    
    func hx_enterIntoChatgroup(id: String, type: EMConversationType) {
        print("hx_enterIntoChatgroup id: \(HuanXin.groupId)")
        let chatController = EaseMessageViewController(conversationChatter: id, conversationType: type)
        self.push(vc: chatController!)
    }
    
    
    func hx_deleteConversation() {
        EMClient.shared().chatManager.deleteConversations(HuanXin.groupConversationIds, isDeleteMessages: true) { (error) in
            if let e = error {
                print("error: \(e)")
                return
            }
        }
    }
    
    func hx_conversationList() -> [Any]? {
        let conversations = EMClient.shared().chatManager.getAllConversations()
        return conversations
    }
    
    func hx_sendMessage() {
        let body = EMTextMessageBody(text: "fasong")
        let message = EMMessage(conversationID: HuanXin.chatConversationIds[0], from: HuanXin.userId, to: "", body: body, ext: nil)
        EMClient.shared().chatManager.send(message, progress: { (progress) in
            print(progress)
        }) { (message, error) in
            if let e = error {
                print("error: \(e.errorDescription)")
                return
            }
            print("message: \(String(describing: message))")
        }
    }
}

extension YYIMConversationViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: YYConversationCell = tableView.dequeueReusableCell(withIdentifier: YYConversationCell.identifier) as! YYConversationCell
        let conversation: EMConversation = self.dataSource[indexPath.row] as! EMConversation
        cell.conversation = conversation
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            self.push(vc: YYEaseConversationListViewController())
            break
        case 1:
            self.push(vc: YYEaseUsersListViewController())
            break
        default:
            break
        }
    }
}

extension YYIMConversationViewController: EMChatManagerDelegate {
    // 会话列表发生变化
    func conversationListDidUpdate(_ aConversationList: [Any]!) {
        print("conversationList: \(aConversationList)")
    }
    // 收消息
    func messagesDidReceive(_ aMessages: [Any]!) {
        print("message: \(aMessages)")
        self.view.showView(text: "message: \(aMessages)")
    }
    // 收到cmd消息
    func cmdMessagesDidReceive(_ aCmdMessages: [Any]!) {
        
    }
    
}
