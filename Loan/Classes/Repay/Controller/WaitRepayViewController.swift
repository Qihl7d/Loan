//
//  WaitRepayViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/10.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

/// 待还款
class WaitRepayViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var repayArray = [RepayModel]() //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Action
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "repayCellIdentifier" {
            let destinationVc = segue.destination as! BillDetailViewController
            destinationVc.orderString = sender as? String /// 订单编号
        }
    }
  
}

extension WaitRepayViewController {
    
    fileprivate func fetchData() {
        
        /// 根据客户id查看借款记录
        
        NetworkTools.fetchRepayLocord(2) { [weak self] (repayData) in
            
            self?.repayArray = repayData
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}

extension WaitRepayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "waitRepayCell", for: indexPath) as! WaitRepayCell
        cell.repayModel = repayArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "repayCellIdentifier", sender: repayArray[indexPath.row].orderNum)
    }
    
}
