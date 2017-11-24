//
//  BillsDetailCell.swift
//  Loan
//
//  Created by lau Andy on 2017/11/10.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class BillsDetailCell: UITableViewCell {

    /// 是否已经还款btn
    @IBOutlet weak var isRepayBtn: UIButton!
    
    /// 分期数
    @IBOutlet weak var numberOfPeriodsLab: UILabel!
    /// 还款时间
    @IBOutlet weak var repayTimeLab: UILabel!
    /// 每期还款金额
    @IBOutlet weak var repayMoneyLab: UILabel!
    
    var orderDetailModel: CustomerOrderDetails? {
        didSet {
            if let model = orderDetailModel {
                
                if let period = model.numberOfPeriods {
                    numberOfPeriodsLab.text = "\(period)期"
                }else {
                    numberOfPeriodsLab.text = ""
                }
                
                /// 表示当前起还款状态 当前期状态:'未还款',0, '已还款',1, '已逾期',2 ,
                if let time = model.repaymentTimeOfEachPeriod, let status = model.repaymentState {
                    
                    if status == 0 {
                        let realTime = time.components(separatedBy: " ").first
                        repayTimeLab.text = realTime! + " 日应还"
                        // 未还款
                        isRepayBtn.setImage(UIImage(named: "repay_unSelect"), for: .normal)
                        
                    }else if status == 1 {
                        let realTime = time.components(separatedBy: " ").first
                        repayTimeLab.text = realTime! + " 已还款"
                        isRepayBtn.setImage(UIImage(named: "repay_select"), for: .normal)
                    }else if status == 2 {
                        let realTime = time.components(separatedBy: " ").first
                        repayTimeLab.text = realTime! + " 已逾期"
                        isRepayBtn.setImage(UIImage(named: "repay_select"), for: .normal)
                    }else {
                        let realTime = time.components(separatedBy: " ").first
                        repayTimeLab.text = realTime! + " 已延期"
                        isRepayBtn.setImage(UIImage(named: "repay_select"), for: .normal)
                    }
   
                }else {
                    repayTimeLab.text = ""
                }

                if let money = model.amountOfRepaymentPerInstalment, let service = model.serviceFeePerTerm {
                    repayMoneyLab.text = "\(money + service)"
                }else {
                    repayMoneyLab.text = ""
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
