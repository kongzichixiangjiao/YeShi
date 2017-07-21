//
//  YYIMGroupViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/12.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUI

class YYIMGroupViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationView()
        
        hx_groupList()
    }
    
    func initNavigationView() {
        self.myTitle = "群组"
    }
    
    override func initTableView() {
        super.initTableView()
        isShowTabbar = true
        tableViewFrameType = .normal64
        registerNibWithIdentifier(YYIMGroupCell.identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        print(EMClient.shared().groupManager.getJoinedGroups())
        EMClient.shared().groupManager.getJoinedGroupsFromServer(withPage: 1, pageSize: 10) { (result, error) in
            if let e = error {
                print("result: \(String(describing: result)), error: \(String(describing: e))")
                return
            }
            self.dataSource = result!
            self.tableView.reloadData()
        }
    }
    
    func hx_enterIntoChatgroup() {
        let chatController = EaseMessageViewController(conversationChatter: HuanXin.groupId, conversationType: EMConversationType.init(2))
        self.push(vc: chatController!)
    }
    
    func hx_groupDetails() {
        EMClient.shared().groupManager.getGroupSpecificationFromServer(withId: HuanXin.groupId) { (group, error) in
            print(group?.groupId ?? "", group?.subject ?? "", group?.description ?? "")
        }
        
    }
}
extension YYIMGroupViewController {
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
        switch indexPath.row {
        case 0:
            hx_enterIntoChatgroup()
            break
        case 1:
            hx_groupDetails()
            break
        default:
            break
        }
    }
}
