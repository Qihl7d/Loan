//
//  BankApproveViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/21.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class BankApproveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        printLog("-----BankApproveViewController已经销毁-----")
    }

    // MARK: - Action
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
