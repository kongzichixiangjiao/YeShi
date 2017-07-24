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

    private let kFontSize: CGFloat = 13
    
    var selectedButton: UIButton!
    
    var titles: [String] = [] {
        didSet {
            initViews()
        }
    }
    
    typealias ClickedHandler = (_ tag: Int) -> ()
    var clickedHandler: ClickedHandler!
    
    convenience init(frame: CGRect, handler: @escaping ClickedHandler) {
        self.init(frame: frame)
        self.clickedHandler = handler
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: kScrollHeaderViewHeight))
        v.showsVerticalScrollIndicator = false;
        v.showsHorizontalScrollIndicator = false;
        self.addSubview(v)
        return v
    }()
    
    func initViews() {
        var offsetW: CGFloat = 0
        for (i , title) in titles.enumerated() {
            let count = titles.count
            let w: CGFloat = count >= 5 ? self.frame.size.width / 4 : self.frame.size.width / count.cgFloat
            let h: CGFloat = self.frame.size.height
            
            let b = UIButton()
            b.tag = i
            b.frame = CGRect(x: i.cgFloat * w, y: 0, width: w, height: h)
            b.setTitle(title, for: .normal)
            b.titleLabel?.font = UIFont.systemFont(ofSize: kFontSize)
            b.setTitleColor(UIColor.orange, for: .selected)
            b.setTitleColor(UIColor.lightText, for: .normal)
            b.isSelected = i == 0
            b.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            self.scrollView.addSubview(b)
            
            if i == 0 {
                selectedButton = b
            }
            
            let vW: CGFloat = title.characters.count.cgFloat * kFontSize
            let v = UIView()
            v.frame = CGRect(x: w / 2 - vW / 2, y: h - 2, width: vW, height: 2)
            v.backgroundColor = UIColor.orange
            v.tag = 1000 + i
            v.alpha = i != 0 ? 0 : 1
            b.addSubview(v)
            
            offsetW += w
        }
        scrollView.contentSize = CGSize(width: offsetW, height: scrollView.frame.size.height)
    }
    
    func buttonAction(sender: UIButton) {
        if sender.tag == selectedButton.tag {
            return
        }
        
        selectedButton.isSelected = false
        (selectedButton.subviews.last!).alpha = 0
        
        sender.isSelected = !sender.isSelected
        selectedButton = sender
        
        UIView.animate(withDuration: 0.35) { 
            (sender.subviews.last!).alpha = 1
        }
        
        print("tag :\(sender.tag)")
        print(titles.count)
        if sender.tag != 0 || sender.tag != 1 || sender.tag != titles.count - 1 || sender.tag != titles.count {
            let x = sender.center.x / 2
            UIView.animate(withDuration: 0.35) {
                self.scrollView.contentOffset = CGPoint(x: x, y: 0)
            }
        }
        
        clickedHandler(sender.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
