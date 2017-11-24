//
//  LoanRecordCell.swift
//  Loan
//
//  Created by lau Andy on 2017/11/22.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class LoanRecordCell: UITableViewCell {
    
    /// 借款时间
    @IBOutlet weak var loanDateLab: UILabel!
    /// 借款金额
    @IBOutlet weak var loanMoneyLabel: UILabel!
    /// 还款状态
    @IBOutlet weak var loanStatusLabel: UILabel!
    
    var repayModel: RepayModel? {
        didSet {
            if let model = repayModel {
                
                if let time = model.createTime {
                    let timeString = time.components(separatedBy: " ").first!
                    loanDateLab.text = "\(timeString)"
                }else {
                    loanDateLab.text = ""
                }
                
                if let money = model.loanAmount {
                    loanMoneyLabel.text = "\(money)"
                }else {
                    loanMoneyLabel.text = ""
                }
                
                // 未审核:0, 审核通过:1, 已还清:2, 放款中:3, 放款完成:4, 审核未通过:5, 未还清:6.
                if let status = model.orderState {
                    
                    if status == 0 {
                        loanStatusLabel.text = "审核中"
                    }else if status == 1 {
                        loanStatusLabel.text = "审核通过"
                    }else if status == 2 {
                        loanStatusLabel.text = "已还清"
                    }else if status == 3 {
                        loanStatusLabel.text = "放款中"
                    }else if status == 4 {
                        loanStatusLabel.text = "放款完成"
                    }else if status == 5 {
                        loanStatusLabel.text = "审核未通过"
                    }else if status == 6 {
                        loanStatusLabel.text = "未还清"
                    }else {
                        loanStatusLabel.isHidden = true
                    }
                    
                }else {
                    loanStatusLabel.isHidden = true
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
