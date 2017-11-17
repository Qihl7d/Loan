//
//  BillDetailViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/10.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

/// 账单详情
class BillDetailViewController: UIViewController {

    fileprivate var repayBtn: UIButton! // 立即还款
    var titleString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 懒加载
    fileprivate lazy var tableView: UITableView = {
        
        var cgFrame: CGRect!
        
        if IS_IPhone_X {
            cgFrame = CGRect(x: 0, y: 0, width: kScreen_w, height: kScreen_h - 88 - 83)
        }else {
            cgFrame = CGRect(x: 0, y: 0, width: kScreen_w, height: kScreen_h - 64 - 49)
        }
        
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.frame = cgFrame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        // 注册cell
        tableView.register(UINib(nibName: "BillsOneCell", bundle: nil), forCellReuseIdentifier: "BillsOneCell")
        
        tableView.register(UINib(nibName: "BillsDetailCell", bundle: nil), forCellReuseIdentifier: "BillsDetailCell")
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        return tableView
    }()

}

extension BillDetailViewController {
    
    fileprivate func setupUI() {
        
        if titleString != nil {
            title = titleString
        }
        
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        
        repayBtn = UIButton(type: .custom)
        repayBtn.backgroundColor = UIColor(hexString: "508fcd")
        repayBtn.setTitle("立即还款", for: .normal)
        repayBtn.setTitleColor(UIColor.white, for: .normal)
        repayBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        repayBtn.addTarget(self, action: #selector(paymentAction), for: .touchUpInside)
        
        view.addSubview(repayBtn)
        
        repayBtn.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.bottom.equalTo(self.view)
            make.leading.trailing.equalTo(self.view)
        }
        
    }
    
    @objc func paymentAction() {
        let paymentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        navigationController?.pushViewController(paymentVC, animated: true)
    }
}

extension BillDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillsOneCell", for: indexPath) as! BillsOneCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillsDetailCell", for: indexPath) as! BillsDetailCell
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 505 : 60
        
    }
 
}
