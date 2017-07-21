//
//  ViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYMyViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationView()
    }
    
    func initNavigationView() {
        self.myTitle = "我的"
        self.isHiddenLeftButton = true
    }
    
    override func initTableView() {
        isShowTabbar = true
        tableViewFrameType = .normal64
        registerNibWithIdentifier(kYYMyBasicCell)
        tableView.tableHeaderView = initTableViewHeaderView()
    }
    
    func initTableViewHeaderView() -> UIView {
        let topView = YYMyTopView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 255))
        return topView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension YYMyViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kYYMyBasicCell)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
