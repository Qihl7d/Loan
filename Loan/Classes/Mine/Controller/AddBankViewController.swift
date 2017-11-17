//
//  AddBankViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/8.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class AddBankViewController: UIViewController {

    @IBOutlet weak var customViewHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        if IS_IPhone_X {
            customViewHeight.constant = 88
        }
        
        var param = [String: Any]()
        param["customerId"] = 2
        param["cardType"] = "招商银行"
        param["carNum"] = "6214 8503 8559 5721"
        
//        NetworkTools.bindingCard(param) { (flag) in
//            
//        }
        
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
