//
//  YYIMCreatChatGroupViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/17.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUILite

class YYIMCreatChatGroupViewController: UIViewController {

    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupContenTextView: UITextView!
    @IBOutlet weak var groupJurisdictionSwitch: UISwitch!
    @IBOutlet weak var groupJurisdictionLabel: UILabel!
    @IBOutlet weak var memberAddJurisdictionSwitch: UISwitch!
    @IBOutlet weak var memberAddJurisdictionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func finishedAction(_ sender: UIButton) {
        createChatGroup()
    }
    
    func createChatGroup() {
        
        HXManager.share.hx_createChatGroup(isGroupJurisdiction: groupJurisdictionSwitch.isOn, isMemberAddJurisdiction: memberAddJurisdictionSwitch.isOn, subject: groupNameTextField.text!, description: groupContenTextView.text, message: "加入吧 骚年") { (success) in
            if success {
                self.view.ga_showView(text: "创建成功", deplay: 0.5)
                return
            }
            self.view.ga_showView(text: "失败！！", deplay: 0.5)
        }
//        let setting = EMGroupOptions()
//        setting.maxUsersCount = 500;
//        
//        var style: EMGroupStyle!
//        // 公开群组
//        if groupJurisdictionSwitch.isOn {
//            if memberAddJurisdictionSwitch.isOn {
//                // 随便加入
//                style = EMGroupStylePublicOpenJoin
//            } else {
//                // Owner可以邀请用户加入; 非群成员用户发送入群申请，经Owner同意后才能入组
//                style = EMGroupStylePublicJoinNeedApproval
//            }
//            // 私有群组
//        } else {
//            if memberAddJurisdictionSwitch.isOn {
//                // 允许群成员邀请其他
//                style = EMGroupStylePublicOpenJoin
//            } else {
//                // 不允许群成员邀请其他
//                style = EMGroupStylePublicJoinNeedApproval
//            }
//        }
//        setting.style = style
//        setting.isInviteNeedConfirm = false 
//        var error: EMError? = EMError()
//        let group = EMClient.shared().groupManager.createGroup(withSubject: groupNameTextField.text, description: groupContenTextView.text, invitees: nil, message: "加入吧，骚年！", setting: setting, error: &error)
//        if let e = error {
//            print("error: \(e)")
//        }
//        
//        print("group: \(String(describing: group))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        myRegignFirstResponder()
    }
    
    private func myRegignFirstResponder() {
        groupNameTextField.resignFirstResponder()
        groupContenTextView.resignFirstResponder()
    }
    
}
