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
                    loadTimeLab.text = time
                }else {
                    loadTimeLab.text = ""
                }
                
                if let money = model.loanAmount {
                    loanMoneyLab.text = "\(money)"
                }else {
                    loanMoneyLab.text = ""
                }
                
                if let status = model.orderState {
                    loanStatusLab.text = status == 0 ? "待还款" : "已还款"
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
