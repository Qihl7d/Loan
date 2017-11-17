//
//  RepayBillsViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/11.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

/// 还款账单
class RepayBillsViewController: UIViewController {

    @IBOutlet weak var customViewTop: NSLayoutConstraint!
    @IBOutlet weak var customViewHeight: NSLayoutConstraint!
    
    /// 懒加载
    fileprivate lazy var tableView: UITableView = {
        
        var cgFrame: CGRect!
        
        if IS_IPhone_X {
            cgFrame = CGRect(x: 0, y: 88, width: kScreen_w, height: kScreen_h - 88)
        }else {
            cgFrame = CGRect(x: 0, y: 64, width: kScreen_w, height: kScreen_h - 64)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if IS_IPhone_X {
            customViewTop.constant = -44
            customViewHeight.constant = 88
        }
        
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
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

extension RepayBillsViewController: UITableViewDelegate, UITableViewDataSource {
    
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

