//
//  YYActivityListViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYActivityListViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTitle = "活动"
        self.setupRightButton(type: .service)
        
        
//        self.tableView.ga_addRefreshHeader(headerView: GA_CircleRefreshHeaderView()) {
//            [weak self] in
//            if let weakSelf = self {
//                print("开始加载")
//                DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * 1000 * 1000000)) / Double(NSEC_PER_SEC), execute: {
//                    DispatchQueue.main.async {
//                        weakSelf.tableView.ga_endRefreshing()
//                        print("加载结束")
//                        weakSelf.tableView.yy_emptyWithReset(handler: { 
//                            [weak weakSelf] in
//                            if let weakWeakSelf = weakSelf {
//                                weakWeakSelf.tableView.yy_empty(.noData, alertTitle: "没啥数据...")
//                            }
//                        })
//                    }
//                })
//                
//            }
//        }
//        self.tableView.ga_beginRefreshing()
        
        
        self.tableView.yy_empty(.noData)
        
        self.tableView.ga_addRefreshHeaderXIB(headerView: GA_AnimationRefreshHeaderView.loadView()) {
            [weak self] in
            if let weakSelf = self {
                print("开始刷新")
                DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * 1000 * 1000000)) / Double(NSEC_PER_SEC), execute: {
                    DispatchQueue.main.async {
                        weakSelf.tableView.ga_XIBendRefreshing()
                        weakSelf.tableView.yy_empty(.noData, alertTitle: "没啥数据...")
                        print("刷新结束")
                    }
                })
            }
        }
//        self.tableView.ga_XIBbeginRefreshing()
        
        self.tableView.ga_addLoadFooter(footerView: GA_LoadMoreView()) {
            [weak self] in
            if let weakSelf = self {
                DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * 1000 * 1000000)) / Double(NSEC_PER_SEC), execute: {
                    DispatchQueue.main.async {
                        weakSelf.tableView.ga_endLoadFooter()
                        print("加载结束")
                    }
                })
            }
        }
    }
    
    override func initTableView() {
        isShowTabbar = true
        tableViewFrameType = .normal64
        registerNibWithIdentifier(YYActivityListCell.identifier)
        self.tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        self.footerView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
    }
}

extension YYActivityListViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYActivityListCell.identifier)
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return YYActivityListCell.height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(vc: YYCompetitionDetailsViewController())
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
