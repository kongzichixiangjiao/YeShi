//
//  YYYeEventViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYYeEventViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationView()
    }
    
    func initNavigationView() {
        self.myTitle = "野事er"
        self.isHiddenLeftButton = true
    }
    
    override func initTableView() {
        isShowTabbar = true
        tableViewFrameType = .normal64
        registerNibWithIdentifier(kYYEventVideoCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension YYYeEventViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kYYEventVideoCell)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            self.navigationController?.pushViewController(YYIMViewcontroller(), animated: true)
            return
        }
        let vc = YYEventDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
