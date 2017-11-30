//
//  AddBankInfoViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/8.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit
import MBProgressHUD

/// 添加银行卡信息
class AddBankInfoViewController: UIViewController {

    @IBOutlet weak var customViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var codeTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if IS_IPhone_X {
            customViewHeight.constant = 88
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
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
        guard phoneTF.text != "" else {
            MBProgressHUD.showMessage("信息未填写完", toView: self.view)
            return
        }
        
        guard codeTF.text != "" else {
            MBProgressHUD.showMessage("信息未填写完", toView: self.view)
            return
        }
        
        performSegue(withIdentifier: "addBankSuccess", sender: nil)
        
    }
}
