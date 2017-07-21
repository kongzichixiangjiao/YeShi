//
//  YYAlertSelectedTableViewHeaderView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/15.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit


public var kYYAlertSelectedTableViewHeaderViewHeight: CGFloat = 30
class YYAlertSelectedTableViewHeaderView: UIView {

    var myTitle: String! {
        didSet {
            self.myTitleLabel.text = myTitle
        }
    }
    
    @IBOutlet weak var myTitleLabel: UILabel!
    @IBOutlet weak var closed: UIButton!
    @IBAction func closedAction(_ sender: UIButton) {
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
