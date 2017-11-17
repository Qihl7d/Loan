//
//  BankSelectViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/8.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

/// 银行卡选择
class BankSelectViewController: UIViewController {
    
    var dataArray: [String] = ["建设银行(1234)","招商银行(2345)","农业银行(3456)","中国银行(4567)"]

    fileprivate lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreen_w, height: kScreen_h - 49), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        // 注册cell
        tableView.register(UINib(nibName: "bankSelectCell", bundle: nil), forCellReuseIdentifier: "bankSelectCell")

        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BankSelectViewController {
    
    fileprivate func setupUI() {
        title = "选择银行卡"
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_question"), style: .plain, target: self, action: #selector(rightBarBarAction))
        
        view.addSubview(tableView)
    }
    
    @objc func rightBarBarAction() {
        printLog("点击了添加按钮")
        
//        let addbankVC = UIStoryboard(name: "Bank", bundle: nil).instantiateViewController(withIdentifier: "AddBankViewController") as! AddBankViewController
//        navigationController?.pushViewController(addbankVC, animated: true)
    }

}

extension BankSelectViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bankSelectCell", for: indexPath) as! bankSelectCell
        cell.bankLab.text = dataArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
