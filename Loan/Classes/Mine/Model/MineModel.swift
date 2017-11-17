//
//  MineModel.swift
//  Loan
//
//  Created by lau Andy on 2017/11/15.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import Foundation

class BankModel {
    
    var id: Int?
    var createTime: String?
    var updateTime: String?
    var customerId: String?
    var cardType: String?
    var carNum: String?
    
    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int
        createTime = dict["createTime"] as? String
        updateTime = dict["updateTime"] as? String
        customerId = dict["customerId"] as? String
        cardType = dict["cardType"] as? String
        carNum = dict["carNum"] as? String
    }
 
}
