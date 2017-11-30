//
//  LoanRecordViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/10.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class LoanRecordViewController: UIViewController {
    
    @IBOutlet weak var customBarTop: NSLayoutConstraint!
    @IBOutlet weak var customBarHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var repayArray = [RepayModel]() //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if IS_IPhone_X {
            customBarTop.constant = -44
            customBarHeight.constant = 88
        }
        
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoanCellIdentifier" {
            let destinationVc = segue.destination as! RepayBillsViewController
            destinationVc.orderString = sender as? String /// 订单编号
        }
    }

}

extension LoanRecordViewController {
    
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

extension LoanRecordViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoanRecordCell", for: indexPath) as! LoanRecordCell
        cell.repayModel = repayArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        performSegue(withIdentifier: "LoanCellIdentifier", sender: repayArray[indexPath.row].orderNum)
    }
    
}
