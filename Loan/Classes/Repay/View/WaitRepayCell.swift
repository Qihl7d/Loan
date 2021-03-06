//
//  WaitRepayCell.swift
//  Loan
//
//  Created by lau Andy on 2017/11/20.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class WaitRepayCell: UITableViewCell {
    
    /// 借款时间
    @IBOutlet weak var loadTimeLab: UILabel!
    /// 借款金额
    @IBOutlet weak var loanMoneyLab: UILabel!
    /// 还款状态
    @IBOutlet weak var loanStatusLab: UILabel!
    
    var repayModel: RepayModel? {
        didSet {
            if let model = repayModel {
                
                if let time = model.createTime {
                    let timeString = time.components(separatedBy: " ").first!
                    loadTimeLab.text = "\(timeString) 借款"
                }else {
                    loadTimeLab.text = ""
                }
                
                if let money = model.loanAmount {
                    loanMoneyLab.text = "\(money)"
                }else {
                    loanMoneyLab.text = ""
                }
                
                // 未审核:0, 审核通过:1, 已还清:2, 放款中:3, 放款完成:4, 审核未通过:5, 未还清:6.
                if let status = model.orderState {
                    
                    if status == 0 {
                       loanStatusLab.text = "审核中"
                    }else if status == 1 {
                       loanStatusLab.text = "审核通过"
                    }else if status == 2 {
                        loanStatusLab.text = "已还清"
                    }else if status == 3 {
                        loanStatusLab.text = "放款中"
                    }else if status == 4 {
                        loanStatusLab.text = "放款完成"
                    }else if status == 5 {
                        loanStatusLab.text = "审核未通过"
                    }else if status == 6 {
                        loanStatusLab.text = "未还清"
                    }else {
                        loanStatusLab.isHidden = true
                    }
  
                }else {
                    loanStatusLab.isHidden = true
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
