//
//  BillsOneCell.swift
//  Loan
//
//  Created by lau Andy on 2017/11/10.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class BillsOneCell: UITableViewCell {
    
    /// 借款编号
    @IBOutlet weak var orderNumLab: UILabel!
    /// 借款时间
    @IBOutlet weak var loanTimeLab: UILabel!
    /// 借款金额
    @IBOutlet weak var loanAmountLab: UILabel!
    /// 借款时长
    @IBOutlet weak var termOfLoanLab: UILabel!
    /// 借款周期
    @IBOutlet weak var numberOfPeriodsLab: UILabel!
    /// 实际到账金额
    @IBOutlet weak var realMoneyLab: UILabel!
    /// 借款利息
    @IBOutlet weak var interestLab: UILabel!
    /// 服务费
    @IBOutlet weak var serviceChargeLab: UILabel!
    /// 到期还款金额
    @IBOutlet weak var repayMoneyLab: UILabel!
    
    var orderModel: CustomerOrder? {
        didSet {
            if let model = orderModel {
                
                if let orderNum = model.orderNum {
                    orderNumLab.text = "账单编号: " + orderNum
                }else {
                    orderNumLab.text = "暂无订单编号"
                }
                
                if let loadTime = model.createTime {
                    loanTimeLab.text = "借款时间: " + loadTime
                }else {
                    loanTimeLab.text = ""
                }
                
                if let amount = model.loanAmount {
                    loanAmountLab.text = "¥\(amount)"
                }else {
                    loanAmountLab.text = ""
                }
                
                if let loanTimes = model.termOfLoan {
                    termOfLoanLab.text = "\(loanTimes)天"
                }else {
                    termOfLoanLab.text = ""
                }
                
                if let period = model.numberOfPeriods {
                    numberOfPeriodsLab.text = "\(period)"
                }else {
                    numberOfPeriodsLab.text = ""
                }
                
                if let realMoney = model.loanAmount {
                    realMoneyLab.text = "¥\(realMoney)"
                }else {
                    realMoneyLab.text = ""
                }

                if let service = model.serviceCharge, let money = model.loanAmount {
                    
                    /// 借款利息
                    interestLab.text = "¥\(0.05/100 * money)"
                    
                    /// 服务费
                    serviceChargeLab.text = "¥\(service)"
                    
                    /// 到期应该还款金额 = 借款本金 + 服务费 + 利息
                    let moneyNum = money + service + 0.05/100 * money
                    repayMoneyLab.text = "¥\(moneyNum)"
  
                }else {
                    serviceChargeLab.text = ""
                }   
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
