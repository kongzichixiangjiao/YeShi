//
//  GA_XIBRefreshHeaderView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/1.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class GA_XIBRefreshHeaderView: GA_RefreshBaseView {
    
    var state: RefreshState = .ed {
        didSet {
            switch self.state {
            case .start:
                self.refreshHandler()
                self.startAnimation()
                break
            case .ing:
                UIView.animate(withDuration: 0.35, delay: 0, options: .allowUserInteraction, animations: {
                    self.scrollView.contentInset = UIEdgeInsetsMake(RefreshKey.kContentInsetTop + self.contentInset.top, self.contentInset.left, self.contentInset.bottom, self.contentInset.right)
                }, completion: { (finished) in
                    
                })
                animationing()
                break
            case .ed:
                UIView.animate(withDuration: 0.35, delay: 0, options: .allowUserInteraction, animations: {
                    self.scrollView.contentInset = self.contentInset
                }, completion: { (finished) in
                    
                })
                stopAnimation()
                break
            case .will:
                willAnimation()
                break
            case .pull:
                pullAnimation()
                break
            case .normal:
                break
            }
        }
    }
    
    func beginRefreshing() {
        self.state = .start
        self.state = .ing
    }
    
    func endRefreshing() {
        self.state = .ed
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.state = .normal
    }
    
    class func loadView() -> GA_XIBRefreshHeaderView {
        return Bundle.main.loadNibNamed(NSStringFromClass(self).components(separatedBy: ".").last!, owner: self, options: nil)?.last as! GA_XIBRefreshHeaderView
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == RefreshKey.kObserverContentOffset {
            let t = object as! UIScrollView
            let y: CGFloat = t.contentOffset.y
            if (y > 0) {
                return
            }
            if self.state != .start && self.state != .ing {
                if (y >= 0) {
                    print("ed -- \(self.state)")
                    self.state = .ed
                } else {
                    if self.state == .ed || self.state == .normal {
                        print("pull -- \(self.state)")
                        self.state = .pull
                    }
                }
                
                if -y >= RefreshKey.kContentOffsetMax && self.state != .normal {
                    self.state = .will
                    print("will -- \(self.state)")
                } else {
                    if -y <= RefreshKey.kContentInsetTop && self.state != .ed {
                        print("pull1 -- \(self.state)")
                        self.state = .pull
                    }
                }
            } else {
                if self.scrollView.contentInset.top == RefreshKey.kContentInsetTop && self.state != .ing {
                    print("end -- \(self.state)")
                    self.state = .ed
                } else {
                    if self.state == .ing && self.scrollView.contentInset.top == 0 {
                        self.state = .ed
                        print("return ed -- \(self.state)")
                    }
                }
            }
            
            if !self.scrollView.isDragging {
                if self.state == .will {
                    self.state = .start
                    print("start -- \(self.state)")
                } else {
                    if self.state == .start {
                        self.state = .ing
                        print("ing -- \(self.state)")
                    } else {
                        if self.scrollView.contentInset.top == 0 {
                            self.state = .ed
                        }
                        print("else ing -- \(self.state)")
                    }
                }
            }
        }
    }
    
    deinit {
        self.scrollView.contentInset = self.contentInset
        self.scrollView.removeObserver(self, forKeyPath: RefreshKey.kObserverContentOffset)
        self.state = .ed
    }
}

extension GA_XIBRefreshHeaderView: GA_RefreshAnimationProtocol {
    func startAnimation() {

    }
    
    func stopAnimation() {

    }
    
    func animationing() {

    }
    
    func willAnimation() {

    }
    
    func pullAnimation() {

    }
}


