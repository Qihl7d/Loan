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
    
    @IBOutlet weak var commitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if IS_IPhone_X {
            navBarHeight.constant = 88
        }
        // 设置代理，并且禁用按钮
        ideaTF.delegate = self
        
        commitBtn.isEnabled = false
        commitBtn.backgroundColor = UIColor(hexString: "e0e0e0")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
    
    
    // MARK: - Action
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func ideaAction(_ sender: UIButton) {
        
        view.endEditing(true)
        
        guard ideaTF.text.characters.count > 5 else {
            
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = .text
            hud.label.text = "反馈内容不能少于5个字，亲～"
            hud.offset = CGPoint(x: 0, y: kScreen_h - 250)
            hud.removeFromSuperViewOnHide = true  // 隐藏时候从父控件中移除
            hud.hide(animated: true, afterDelay: 2.0)
        
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

extension FeedbackViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "你的建议就是对我们最大的帮助" {
            textView.text = ""
            textView.textColor = UIColor.darkGray
        }
 
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // 做一个判断 有内容就阔以不禁用提交按钮
        let changedString = NSMutableString(string: textView.text)
        changedString.replaceCharacters(in: range, with: text)
        
        if changedString.length != 0 {
            commitBtn.isEnabled = true
            commitBtn.backgroundColor = UIColor(hexString: "508FCD")
        }else {
            commitBtn.isEnabled = false
            commitBtn.backgroundColor = UIColor(hexString: "e0e0e0")
        }
        return true
    }
    
    
}
