//
//  YYAlertViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/12.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYAlertViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func showWithSelf(vc: UIViewController) {
        vc.present(self, animated: false, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let _ = self.presentingViewController else {
            return
        }
        
        let basicAnimation          = CABasicAnimation(keyPath: KeyPath.scale.rawValue)
        
        basicAnimation.fromValue    = 1
        basicAnimation.toValue      = 0.5
        basicAnimation.autoreverses = false
        basicAnimation.duration     = 2
        self.view.layer.add(basicAnimation, forKey: "")
        
        self.view.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
    }
    
    public func dismiss() {
        dismiss(animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss()
    }
    
    deinit {
        print("deinit")
    }
    
}

