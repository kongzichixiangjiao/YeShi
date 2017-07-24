//
//  YYApplyViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/5.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import Social

class YYApplyViewController: YYBaseTableViewController {
    
    lazy var headerView: UIView = {
        let v = YYApplyHeaderView.ga_loadView()
        v.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: YYApplyHeaderView.kHEIGHT)
        
        let header = UIView()
        header.frame = v.bounds
        header.addSubview(v)
        
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTitle = "报名"
        self.setupRightButton(type: .finished)
        
        self.rightButtonState = .normal
        initData()
        
        initBackView()
        
        initNotificationCenter()
        
        showShare()
        
    }
    
    func showShare() {
        if !SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            return
        }
        guard let vc = SLComposeViewController.init(forServiceType: SLServiceTypeTwitter) else {
            return
        }
        vc.setInitialText("setInitialText")
        vc.add(UIImage(named: "comptition_header_normal"))
        vc.add("blog.csdn.net/lincsdnnet".ga_url);
        self.present(vc, animated: true, completion: nil)
        vc.completionHandler = {
            [weak self] a in
            print(a)
            if (a == .cancelled) {
                
            } else {
                
            }
        }
    }
    
    func initNotificationCenter() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { (notification) in
            let rect: CGRect = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
            self.tableView.frame = CGRect(x: 0, y: 64, width: self.tableView.width, height: MainScreenHeight - rect.size.height - 64)
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (notifi) in
            self.tableViewFrameType = .normal64
        }
    }
    
    func initData() {
        let path = Bundle.ga_path("apply.plist")
        let data: [Any] = (NSDictionary.init(contentsOfFile: path) as! [String : Any])["list"] as! [Any]
        for dic: [String : Any] in data as! [[String : Any]] {
            let model = YYApplyModel(dic: dic)
            self.dataSource.append(model)
        }
    }
    
    override func initTableView() {
        isShowTabbar = true
        tableViewFrameType = .normal64
        registerNibWithIdentifier(YYApplyTextTableViewCell.identifier)
        registerNibWithIdentifier(YYApplySelectedTableViewCell.identifier)
        registerNibWithIdentifier(YYApplyAddImageTableViewCell.identifier)
        
        tableView.tableHeaderView = self.headerView
        tableView.backgroundColor = UIColor.clear
    }
    
    private func initBackView() {
        let imgV = UIImageView(image: UIImage(named: ""))
        imgV.frame = CGRect(x: 0, y: NavigationViewHeight, width: MainScreenWidth, height: 350.0)
        imgV.clipsToBounds = false
        imgV.contentMode = .scaleAspectFill
        self.view.insertSubview(imgV, at: 0)
        let b = UIBlurEffect(style: UIBlurEffectStyle.light)
        let v = UIVibrancyEffect(blurEffect: b)
        let effectView = UIVisualEffectView(effect: v)
        effectView.frame = imgV.bounds
        imgV.addSubview(effectView)
    }
    
    override func clickedRightButtonAction(sender: UIButton) {

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pickerValueChange(_ sender: UIDatePicker) {
        print(sender.date)
    }
}

extension YYApplyViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model: YYApplyModel = self.dataSource[indexPath.row] as! YYApplyModel
        if model.type == YYApplyCellType.text.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: YYApplyTextTableViewCell.identifier) as! YYApplyTextTableViewCell
            cell.myDelegate = self
            cell.model = model
            cell.row = indexPath.row
            return cell
        } else if model.type == YYApplyCellType.selected.rawValue || model.type == YYApplyCellType.picker.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: YYApplySelectedTableViewCell.identifier) as! YYApplySelectedTableViewCell
            cell.myDelegate = self
            cell.model = model
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: YYApplyAddImageTableViewCell.identifier) as! YYApplyAddImageTableViewCell
            cell.model = model
            cell.myDelegate = self
            cell.myRow = indexPath.row
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model: YYApplyModel = self.dataSource[indexPath.row] as! YYApplyModel
        if model.type == YYApplyCellType.image.rawValue {
            return 105
        }
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var model: YYApplyModel = self.dataSource[indexPath.row] as! YYApplyModel
        
        if model.type == YYApplyCellType.text.rawValue {
            tableView.deselectRow(at: indexPath, animated: true)
        } else if model.type == YYApplyCellType.selected.rawValue {
            self.view.ga_showSelectedLoading(title: model.key, data: model.data!, handler: { (row, obj) in
                model.value = model.data?[row]
                self.dataSource[indexPath.row] = model
                self.tableView.reloadData()
            })
        } else if model.type == YYApplyCellType.picker.rawValue {
            self.view.ga_showBirthdayView(handler: { (row, obj) in
                model.value = (obj as! Date).description
                self.dataSource[indexPath.row] = model
                self.tableView.reloadData()
            })
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension YYApplyViewController: YYApplyContentDelegate {
    func finishedContent(content: String?, andRow row: Int) {
        var model: YYApplyModel = self.dataSource[row] as! YYApplyModel
        model.value = content
        self.dataSource[row] = model
    }
}

extension YYApplyViewController: YYApplyAddImageTableViewCellDelegate {
    func didSelectedImage(tag: Int, row: Int) {
        let picker = YYBaseImagePickerController()
        picker.delegate = self
        picker.model = YYBaseImagePickerControllerModel(row: row, tag: tag)
        self.present(picker, animated: true, completion: nil)
    }
}

extension YYApplyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let p = picker as! YYBaseImagePickerController
        var model: YYApplyModel = self.dataSource[p.model!.row] as! YYApplyModel

        model.imageData?[p.model.tag] = (info["UIImagePickerControllerOriginalImage"] as! UIImage).compressImage(maxLength: 1024*1024*1)!
        self.dataSource[p.model!.row] = model
        self.tableView.reloadData()
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

