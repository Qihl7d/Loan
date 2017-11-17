//
//  HomeModel.swift
//  Loan
//
//  Created by lau Andy on 2017/11/15.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import Foundation

/// 首页和我的model～
class HomeModel {
    
    /// 客户姓名
    var customerName: String?
    
    /// 可用额度
    var availableQuota: Int?
    
    /// 总额度
    var totalAmount: Int?
    
    /// 加入的总人数
    var totalPersonNumber: Int?
    
    init(dict: [String: AnyObject]) {
        customerName = dict["customerName"] as? String
        availableQuota = dict["availableQuota"] as? Int
        totalAmount = dict["totalAmount"] as? Int
        totalPersonNumber = dict["totalPersonNumber"] as? Int
    }
    
    
}

/// 根据电话获取顾客的所有基本信息
class BaseInfoModel {
    
}
