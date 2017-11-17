//
//  PaymentViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/11.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit
import MBProgressHUD

/// 支付方式
class PaymentViewController: UIViewController {

    /// 还款金额
    @IBOutlet weak var repayMoneyLab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "支付方式"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Action
    
    @IBAction func bankAction(_ sender: UIButton) {
        MBProgressHUD.showMessage("点击了银行卡还款", toView: self.view)
    }
    
    @IBAction func weChatAction(_ sender: UIButton) {
        MBProgressHUD.showMessage("点击了微信还款", toView: self.view)
        
    }
    
    @IBAction func zfbAction(_ sender: UIButton) {
        MBProgressHUD.showMessage("点击了支付宝还款", toView: self.view)
    }
    
}
