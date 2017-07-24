//
//  YYBaseTableViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

enum TableViewFrameType: CGFloat {
    case normal0 = 0
    case normal20 = 20
    case normal64 = 64
    case normal108 = 108
}

public var MainScreenWidth = UIScreen.main.bounds.width
public var MainScreenHeight = UIScreen.main.bounds.height

class YYBaseTableViewController: YYBaseViewController {

    public var dataSource: [Any] = []
    
    public var isShowTabbar: Bool = false
    
    public var showSearchBar: Bool = false 
    
    public var tableViewFrameType: TableViewFrameType! {
        didSet {
            let y: CGFloat = tableViewFrameType.rawValue
            self.tableView.frame = CGRect(x: 0, y: y, width: MainScreenWidth, height: MainScreenHeight - y - (self.isShowTabbar ? TabBarHeight : 0))
        }
    }
    
    lazy var tableView: UITableView = {
        let t = UITableView(frame: CGRect.zero)
        t.delegate = self
        t.dataSource = self
        t.showsHorizontalScrollIndicator = false
        t.showsVerticalScrollIndicator = false
        t.separatorStyle = .none 
        t.tableFooterView = UIView()
        self.view.addSubview(t)
        return t
    }()
    
    private func initFooterView() -> YYBaseTableViewFooterView{
        let footerView = Bundle.main.loadNibNamed("YYBaseTableViewFooterView", owner: self, options: nil)?.last as! YYBaseTableViewFooterView
        return footerView
    }
    
    public func footerView() {
//        self.tableView.tableFooterView = initFooterView()
    }
    
    public func registerClassWithIdentifier(_ identifier: String) {
        tableView.register(NSClassFromString(identifier), forCellReuseIdentifier: identifier)
    }
    
    public func registerNibWithIdentifier(_ identifier: String) {
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        self.tableViewFrameType = .normal64
    }
    
    func initTableView() {
        
    }
    
    func textFieldShouldReturn(text: String) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension YYBaseTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
}
