//
//  YYYeEventViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUILite

enum YYEventShotViewList: String {
    case creatGroup = "创建群组", addFriend = "添加好友", presentStepNumber = "送步数"
}

class YYYeEventViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationView()
        
//        let groups = EMClient.shared().groupManager.getJoinedGroups()
//        self.dataSource = groups!
//        self.tableView.reloadData()
        
        let pageView = YYPagingView(frame: CGRect(x: 0, y: NavigationViewHeight, width: MainScreenWidth, height: MainScreenHeight - NavigationViewHeight), vcs: [YYNewsViewController(), YYNewsViewController(), YYNewsViewController(), YYNewsViewController(), YYNewsViewController(), YYNewsViewController()]) { (tag) in
            print("tag: \(tag)")
        }
        self.view.addSubview(pageView)
    }
    
    func initNavigationView() {
        self.myTitle = "野事er"
        self.isHiddenLeftButton = true
        self.setupRightButton(type: .add)
    }
    
    override func initTableView() {
//        isShowTabbar = true
//        tableViewFrameType = .normal64
//        registerNibWithIdentifier(YYIMGroupCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func clickedRightButtonAction(sender: UIButton) {
        YYShotView.show(point: sender, items: [YYEventShotViewList.creatGroup.rawValue, YYEventShotViewList.addFriend.rawValue, YYEventShotViewList.presentStepNumber.rawValue]) {
            [weak self] title in
            if let weakSelf = self {
                weakSelf.clickedShotViewList(title: title)
            }
        }
    }
    
    func clickedShotViewList(title: String) {
        switch title {
        case YYEventShotViewList.creatGroup.rawValue:
            self.push(vc: YYIMCreatChatGroupViewController())
            break
        case YYEventShotViewList.addFriend.rawValue:
            break
        case YYEventShotViewList.presentStepNumber.rawValue:
            break
        default:
            break 
        }
    }
}

extension YYYeEventViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYIMGroupCell.identifier) as! YYIMGroupCell
        let group = self.dataSource[indexPath.row] as! EMGroup
        cell.titleLabel.text = group.subject
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = YYIMGroupInfoViewController()
        vc.groupId = (self.dataSource[indexPath.row] as! EMGroup).groupId
        self.push(vc: vc)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
