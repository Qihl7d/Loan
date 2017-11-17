//
//  RepayModel.swift
//  Loan
//
//  Created by lau Andy on 2017/11/15.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import Foundation

class RepayModel {
    
    /// 订单时间
    var createTime: String?
    
    /// 借款金额
    var loanAmount: Float?
    
    /// 订单编号
    var orderNum: String?
    
    /// 订单状态
    var orderState: Int?

    init(dict: [String: AnyObject]) {
        createTime = dict["createTime"] as? String
        loanAmount = dict["loanAmount"] as? Float
        orderNum = dict["orderNum"] as? String
        orderState = dict["orderState"] as? Int
    }

}

class CustomerOrder {
    
    var id: Int?
    
    /// 申请分期时间
    var applyByStagesTime: String?
    
    /// 申请分期时间
    var createTime: String?
    
    /// 客户id
    var customerId: Int?
    
    /// 分期详情
    var customerOrderDetails: [CustomerOrderDetails]? = []

    /// 是否分期
    var isByStages: Bool?
    
    /// 借款金额
    var loanAmount: Float?
    
    /// 分期周期
    var numberOfPeriods: Int?
    
    /// 订单编号
    var orderNum: String?
    
    /// 订单状态
    var orderState: Int?
    
    /// 还款总金额
    var repaymentAmount: Float?
    
    /// 还款金额
    var returnAmount: Float?
    
    /// 服务费
    var serviceCharge: Float?
    
    /// 借款时长
    var termOfLoan: Int?
    
    /// 更新时间
    var updateTime: String?
    
    
}

class CustomerOrderDetails {
    
    var id: Int?
    
    /// 每期应金额
    var amountOfRepaymentPerInstalment: Float?
    
    /// 时间
    var createTime: String?
    
    /// 分期数
    var numberOfPeriods: Int?
    
    /// 订单编号
    var orderNum: String?
    
    /// 还款时间
    var repaymentTime: String?
    
    /// 每期还款截止时间
    var repaymentTimeOfEachPeriod: String?
    
    /// 每期手续费
    var serviceFeePerTerm: Float?
    
    /// 还款单号
    var tradeNo: String?
    
    /// 更新时间
    var updateTime: String?
}
