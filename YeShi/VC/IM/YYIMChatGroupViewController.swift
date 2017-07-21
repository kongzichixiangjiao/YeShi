//
//  YYIMChatGroupViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/17.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYIMChatGroupViewController:  YYIMBaseViewController {

    var group: EMGroup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imTitle = group.subject
        self.navigationView.setupRightButton(type: .imGroupDetails)
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func clickedRightButtonAction(sender: UIButton) {
        super.clickedRightButtonAction(sender: sender)
        let vc = YYIMGroupInfoViewController()
        vc.groupId = group.groupId
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

