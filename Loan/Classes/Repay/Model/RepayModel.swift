//
//  RepayModel.swift
//  Loan
//
//  Created by lau Andy on 2017/11/15.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import Foundation

/// 借款model
class RepayModel {
    
    /// 订单时间
    var createTime: String?
    
    /// 借款金额
    var loanAmount: Float?
    
    /// 订单编号
    var orderNum: String?
    
    /// 订单状态 未审核:0, 审核通过:1, 已还清:2, 放款中:3, 放款完成:4, 审核未通过:5, 未还清:6.
    var orderState: Int?

    init(dict: [String: AnyObject]) {
        createTime = dict["createTime"] as? String
        loanAmount = dict["loanAmount"] as? Float
        orderNum = dict["orderNum"] as? String
        orderState = dict["orderState"] as? Int
    }

}

/// 订单model～
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
    
    /// 订单状态 0:'未还款', 1:'已经还款', 2:'已逾期'
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
    
//    init(dict: [String: AnyObject]) {
//        id = dict["id"] as? Int
//        applyByStagesTime = dict["applyByStagesTime"] as? String
//        createTime = dict["createTime"] as? String
//        customerId = dict["customerId"] as? Int
//        customerOrderDetails = dict["customerOrderDetails"] as? [CustomerOrderDetails]
//        isByStages = dict["isByStages"] as? Bool
//        loanAmount = dict["loanAmount"] as? Float
//        numberOfPeriods = dict["numberOfPeriods"] as? Int
//        orderNum = dict["orderNum"] as? String
//        orderState = dict["orderState"] as? Int
//        repaymentAmount = dict["repaymentAmount"] as? Float
//        returnAmount = dict["returnAmount"] as? Float
//        serviceCharge = dict["serviceCharge"] as? Float
//        termOfLoan = dict["termOfLoan"] as? Int
//        updateTime = dict["updateTime"] as? String
//    }
}

/// 订单详情model～
class CustomerOrderDetails {
    
    var id: Int?
    
    /// 订单编号
    var orderNum: String?
    
    /// 每期手续费
    var serviceFeePerTerm: Float?
    
    /// 每期还款截止时间
    var repaymentTimeOfEachPeriod: String?

    /// 分期数
    var numberOfPeriods: Int?
    
    /// 当前期状态:'未还款',0,'已经还款1',1,'已逾期',2 ,
    var repaymentState: Int?
    
    /// 逾期产生费用
    var overdueMoney: Float?
    
    /// 还款时间
    var repaymentTime: String?

    /// 时间
    var createTime: String?
    
    /// 还款单号
    var tradeNo: String?
    
    /// 每期应金额
    var amountOfRepaymentPerInstalment: Float?
    
    /// 是否逾期
    var isOverdue: Bool?
    
    /// 更新时间
    var updateTime: String?
    
//    init(dict: [String: AnyObject]) {
//        id = dict["id"] as? Int
//        amountOfRepaymentPerInstalment = dict["amountOfRepaymentPerInstalment"] as? Float
//        createTime = dict["createTime"] as? String
//        numberOfPeriods = dict["numberOfPeriods"] as? Int
//        orderNum = dict["orderNum"] as? String
//        repaymentTime = dict["repaymentTime"] as? String
//        repaymentTimeOfEachPeriod = dict["repaymentTimeOfEachPeriod"] as? String
//        serviceFeePerTerm = dict["serviceFeePerTerm"] as? Float
//        tradeNo = dict["tradeNo"] as? String
//        updateTime = dict["updateTime"] as? String
//    }
}
