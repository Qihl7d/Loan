//
//  LendView.swift
//  Loan
//
//  Created by lau Andy on 2017/11/8.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

protocol LendViewDelegate: class {
    func btnActionWith(_ lendView: LendView, index: Int)
}

class LendView: UIView {
    
    /// 借款期限
    @IBOutlet weak var dayLab: UILabel!
    /// 每期还款金额
    @IBOutlet weak var repayLab: UILabel!
    /// 利息
    @IBOutlet weak var interestLab: UILabel!
    /// 服务费
    @IBOutlet weak var serviceLab: UILabel!
    /// 借款到账的钱
    @IBOutlet weak var getMoneyLab: UILabel!
    
    weak var delegate: LendViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func loadLendViewWithXib() -> LendView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as! LendView
    }
    
    // MARK: - Action
    
    /// 贷款期限
    @IBAction func deadlineAction(_ sender: UIButton) {
        delegate?.btnActionWith(self, index: 0)
    }
    
    /// 问题咨询
    @IBAction func questionAction(_ sender: UIButton) {
        delegate?.btnActionWith(self, index: 1)
    }
    
    ///  银行绑定
    @IBAction func bankBindingAction(_ sender: UIButton) {
        delegate?.btnActionWith(self, index: 2)
    }
    
    /// 立即借款
    @IBAction func lendAction(_ sender: UIButton) {
        delegate?.btnActionWith(self, index: 3)
    }
    

}
