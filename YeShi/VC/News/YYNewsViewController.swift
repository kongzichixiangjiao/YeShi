//
//  YYNewsViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/18.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYNewsViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        EMClient.shared().contactManager.add(self, delegateQueue: nil)
    }
    
    override func initTableView() {
        super.initTableView()
        isShowTabbar = true
        tableViewFrameType = .normal64
        registerNibWithIdentifier(YYIMAddFriendCell.identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loginUserName() -> String {
        return EMClient.shared().currentUsername
    }
    
    deinit {
        EMClient.shared().contactManager.removeDelegate(self)
    }
}

extension YYNewsViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYIMAddFriendCell.identifier) as! YYIMAddFriendCell
        cell.userNameLabel.text = self.dataSource[indexPath.row] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension YYNewsViewController: EMContactManagerDelegate {
    /*!
     *  用户B同意用户A的加好友请求后，用户A会收到这个回调
     */
    func friendRequestDidApprove(byUser aUsername: String!) {
        self.view.ga_showView(text: aUsername)
    }
    
    /*!
     *  用户B拒绝用户A的加好友请求后，用户A会收到这个回调
     */
    func friendRequestDidDecline(byUser aUsername: String!) {
    
    }
    
    /*!
     *  用户B删除与用户A的好友关系后，用户A，B会收到这个回调
     */
    func friendshipDidRemove(byUser aUsername: String!) {
    
    }
    
    /*!
     *  用户B同意用户A的好友申请后，用户A和用户B都会收到这个回调
     */
    func friendshipDidAdd(byUser aUsername: String!) {
        self.view.ga_showView(text: aUsername)
    }
    
    /*!
     *  用户B申请加A为好友后，用户A会收到这个回调
     */
    func friendRequestDidReceive(fromUser aUsername: String!, message aMessage: String!) {
        self.dataSource.append(aUsername)
        self.tableView.reloadData()
        
    }
}
