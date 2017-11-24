//
//  CreditModel.swift
//  Loan
//
//  Created by lau Andy on 2017/11/15.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import Foundation

/// 信用model
class CreditModel {
    
    ///  客户id
    var id: Int?
    
    /// 是否电话认证通过(false:未认证,true:认证)
    var isTelAuthentication: Bool?
    
    /// 是否身份认证通过(false:未认证,true:认证)
    var isCardAuthentication: Bool?
    
    /// 是否人脸识别通过(false:未通过,true:通过)
    var isFaceRecognition: Bool?
    
    /// 是否开启静默(false:未开启,true:开启)
    var isSilence: Bool?
    
    /// 是否芝麻信用认证通过
    var isSesameCredit: Bool?
    
    /// 信用评分
    var creditScore: Int?
    
    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int
        isTelAuthentication = dict["isTelAuthentication"] as? Bool
        isCardAuthentication = dict["isCardAuthentication"] as? Bool
        isFaceRecognition = dict["isFaceRecognition"] as? Bool
        isSilence = dict["isSilence"] as? Bool
        isSesameCredit = dict["isSesameCredit"] as? Bool
        creditScore = dict["creditScore"] as? Int
    }
}

/// 通讯录model
class AddressBookModel {
    
    /// 姓名
    var communicationName: String = ""
    /// 电话号码
    var communicationTel: String = ""
}

