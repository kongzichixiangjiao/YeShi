//
//  YYPagingHeaderScrollView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/31.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

public let kScrollHeaderViewHeight: CGFloat = 44

class YYPagingHeaderScrollView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: kScrollHeaderViewHeight))
        v.showsVerticalScrollIndicator = false;
        v.showsHorizontalScrollIndicator = false;
        self.addSubview(v)
        return v
    }()
    
    func initViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
