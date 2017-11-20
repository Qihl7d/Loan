//
//  RepayViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/7.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class RepayViewController: UIViewController {

    @IBOutlet weak var amoutLab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
        /// 表示登录成功在请求数据
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: Notification.Name.Task.loginSuccess, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Action
    
    @IBAction func historyRecordAction(_ sender: UIButton) {
//        let billVC = BillDetailViewController()
//        billVC.titleString = "借款记录"
//        navigationController?.pushViewController(billVC, animated: true)
    }
    
    /// 银行卡还款
    @IBAction func bankClickedAction(_ sender: UIButton) {
        printLog("银行卡还款")
    }
    
    /// 微信还款
    @IBAction func wechatClickedAction(_ sender: UIButton) {
        printLog("微信还款")

    }
    
    /// 支付宝还款
    @IBAction func zfbClickedAction(_ sender: UIButton) {
        printLog("支付宝还款")
    }
    
}

extension RepayViewController {
    
    fileprivate func setupUI() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#508fcd")
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc fileprivate func fetchData() {
        
        if isLogin().0 {
            NetworkTools.repayAmount(2) { (value) in
                DispatchQueue.main.async {
                    self.amoutLab.text = "¥\(value)"
                }
            }
        }
    }
}
