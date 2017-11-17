//
//  AddBankInfoViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/8.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

/// 添加银行卡信息
class AddBankInfoViewController: UIViewController {

    @IBOutlet weak var customViewHeight: NSLayoutConstraint!
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
    
}
