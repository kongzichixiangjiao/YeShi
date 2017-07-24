//
//  YYIMFriendViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/13.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUILite

class YYIMFriendViewController: YYBaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationView()
        EMClient.shared().contactManager.add(self, delegateQueue: nil)
    }
    
    func initNavigationView() {
        self.myTitle = "群组"
        self.navigationView.setupRightButton(type: .normal)
    }
    
    override func clickedRightButtonAction(sender: UIButton) {
        super.clickedRightButtonAction(sender: sender)
        
        guard let error = EMClient.shared().contactManager.addContact("", message: "加好友") else {
            return
        }
        print("error: \(error.errorDescription)")
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
}
extension YYIMFriendViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: YYIMGroupCell = tableView.dequeueReusableCell(withIdentifier: YYIMGroupCell.identifier) as! YYIMGroupCell
        cell.titleLabel.text = String(describing: self.dataSource[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension YYIMFriendViewController: EMContactManagerDelegate {
    // 同意加好友
    func friendRequestDidApprove(byUser aUsername: String!) {
        
    }
    
    // 拒绝加好友
    func friendRequestDidDecline(byUser aUsername: String!) {
        
    }
    
    // 删除好友
    func friendshipDidRemove(byUser aUsername: String!) {
        
    }
    
    // 申请好友
    func friendshipDidAdd(byUser aUsername: String!) {
        
    }
    
    // 收到申请好友
    func friendRequestDidReceive(fromUser aUsername: String!, message aMessage: String!) {
        
    }
    
}
