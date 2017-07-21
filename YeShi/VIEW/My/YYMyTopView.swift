//
//  YYMyTopView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/23.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYMyTopView: UIView {

    lazy var backImageView: UIImageView = {
        let v = UIImageView()
        v.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 240)
        v.image = UIImage.init(named: "IMG_1948")
        return v
    }()
    
    lazy var effectView: UIVisualEffectView = {
        let v = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
        v.frame = self.backImageView.bounds
        return v
    }()
    
    lazy var spaceView: UIView = {
        let v = UIView()
        v.frame = CGRect(x: 0, y: self.backImageView.frame.size.height, width: self.backImageView.frame.size.width, height: 15)
        v.backgroundColor = UIColor.gray
        return v
    }()
    
    lazy var headerButton: UIButton = {
        let v = UIButton()
        let w: CGFloat = 65
        let x: CGFloat = self.center.x - w / 2
        let y: CGFloat = self.center.y - w / 2 - 40
        v.frame = CGRect(x: x, y: y, width: w, height: w)
        v.setImage(UIImage.init(named: "IMG_1948"), for: .normal)
        v.addTarget(self, action: #selector(clickedHeader(sender:)), for: .touchUpInside)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initBackViews()
        
        initViews()
    }
    
    func clickedHeader(sender: UIButton) {
        
    }
    
    private func initViews() {
        self.addSubview(headerButton);
    }
    
    private func initBackViews() {
        self.addSubview(spaceView)
        self.addSubview(backImageView)
        self.addSubview(effectView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
