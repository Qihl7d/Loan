//
//  FeedbackViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/16.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit
import MBProgressHUD

/// 意见反馈
class FeedbackViewController: UIViewController {

    
    @IBOutlet weak var navBarHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var ideaTF: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if IS_IPhone_X {
            navBarHeight.constant = 88
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Action
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func ideaAction(_ sender: UIButton) {
        
        view.endEditing(true)
        
        guard ideaTF.text != "你的建议就是对我们最大的帮助" else {
            
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = .text
            hud.label.text = "反馈内容不能为空哦，亲～"
            hud.offset = CGPoint(x: 0, y: kScreen_h - 250)
            hud.removeFromSuperViewOnHide = true  // 隐藏时候从父控件中移除
            hud.hide(animated: true, afterDelay: 2.0)
            
//            @param direction：抖动方向（默认是水平方向）
//            @param times：抖动次数（默认5次）
//            @param interval：每次抖动时间（默认0.1秒）
//            @param delta：抖动偏移量（默认2）
//            @param completion：抖动动画结束后的回调
            ideaTF.shake(direction: .horizontal, times: 5, interval: 0.1, delta: 4, completion: nil)
            
            return
        }
        
        sleep(1)
        DispatchQueue.main.async {
            MBProgressHUD.showMessage("你的宝贵意见已接纳，谢谢亲～", toView: keyView)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
