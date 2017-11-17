//
//  NetworkTools.swift
//  Loan
//
//  Created by lau Andy on 2017/11/7.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum MethodType {
    case get
    case post
}

/// 网络请求类
class NetworkTools {
    
    class func request(_ url: String, type: MethodType, parameters: [String: Any]? = nil, complete: @escaping (_ isSuccess: Bool, _ result: Any) -> Void) {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(url, method: method, parameters: parameters).responseJSON { (response) in
            
            guard let result = response.result.value else {
                complete(false, response.result.error ?? "请求出错")
                printLog("请求出错----\(String(describing: response.result.error))")
                return
            }
            complete(true, result)
        }
        
        
    }
    
    /*
     let manager = NetworkReachabilityManager(host: "www.apple.com")
     
     manager?.listener = { status in
     printLog("当前网络状态: \(status)")
     }
     manager?.startListening()
     
     deinit {
     stopListening()
     }
     
     //        let headers: HTTPHeaders = [
     //            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
     //            "Accept": "application/json"
     //        ]
     
     */
    
    
    /// 数组转化为json
    class func arrayToParseJSONString(arr: Array<Any>) -> String {
        let data =  try? JSONSerialization.data(withJSONObject: arr, options: JSONSerialization.WritingOptions.prettyPrinted)
        let str = String(data: data!, encoding: String.Encoding.utf8)
        return str!
    }
    
    
    
    class func saveAddressBook(_ params: [String: Any], complete: @escaping (_ flag: Bool) -> Void) {
        
        //let url = "http://192.168.0.101:8080/parent/customerAddressList/test"
        //let paramss: [String: Any] = ["customerTel":"123","lists": [["customerTel": "12345","verifyCode": "lanchao"]],"verifyCode":"13"]
        
        var param = [String: Any]()
        param["customerId"] = 2
        param["communicationName"] = "姓名"
        param["communicationTel"] = "电话号码: 10086"
        
        var parameters = [String: Any]()
        parameters["lists"] = [param,param]
        
        Alamofire.request(saveAddressList, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                printLog("数据错误-----\(response.error!.localizedDescription)")
                return
            }
            
            // 直接解析
            if let value = response.result.value {
                
                let json = JSON(value)
                printLog("通讯录保存---\(json)")
                let isSuccess = json["isSuccess"].boolValue
                
                if isSuccess {
                    complete(true)
                }else {
                    complete(false)
                }
            }
        }
    }
    
}

// MARK: -客服订单信息
extension NetworkTools {
    
    /// 还款界面(获取本期该还款多少)
    class func repayAmount(_ customerId: Int, complete: @escaping (_ value: Int) -> Void) {
        
        request(repayInfo + "\(customerId)", type: .post) { (flag, result) in
            guard flag == true else {
                return
            }
            
            // 直接解析
            let json = JSON(result)
            printLog("还款界面信息---\(json)")
            let code = json["code"].intValue
            let rows = json["rows"].dictionaryObject
            
            if code == 200, let data = rows {
                let model = data["repaymentAggregateMoney"] as! Int
                complete(model)
            }
        }
        
    }
    
    
    
    
    
    
    
}

// MARK: -客服基本信息管理
extension NetworkTools {
    
    /// 首页和我的界面信息
    class func fetchMineInfo(_ tel: String, complete: @escaping (_ value: HomeModel) -> Void) {
        
        request(fetchHomeInfo + tel, type: .post) { (flag, result) in
            guard flag == true else {
                return
            }
            
            // 直接解析
            let json = JSON(result)
            printLog("首页和我的界面信息---\(json)")
            let code = json["code"].intValue
            let rows = json["rows"].dictionaryObject
            
            if code == 200, let data = rows {
                let model = HomeModel(dict: data as [String: AnyObject])
                complete(model)
            }
        }
    }
    
}

// MARK: - 客服认证信息
extension NetworkTools {
    
    /// 信用界面
    class func fetchCreditInfo(_ tel: String, complete: @escaping (_ value: CreditModel) -> Void) {
        
        request(fetchCreditPoints + tel, type: .get) { (flag, result) in
            guard flag == true else {
                return
            }
            
            // 直接解析
            let json = JSON(result)
            printLog("信用界面---\(json)")
            let isSuccess = json["isSuccess"].boolValue
            let rows = json["rows"].dictionaryObject
            
            if isSuccess {
                let model = CreditModel(dict: rows! as [String: AnyObject])
                complete(model)
            }
        }
    }
    
    
}

// MARK: - 客服银行卡信息
extension NetworkTools {
    
    /// 绑定银行卡
    class func bindingCard(_ params: [String: Any], complete: @escaping (_ flag: Bool) -> Void) {
        
        request(bindingBandCard, type: .post, parameters: params) { (isFlag, value) in
            guard isFlag == true else {
                return
            }
            
            // 直接解析
            let json = JSON(value)
            printLog("绑定银行卡---\(json)")
            let isSuccess = json["isSuccess"].boolValue
            
            if isSuccess {
                complete(true)
            }else {
                complete(false)
            }
        }
        
    }
    
    /// 根据客服id，获取其绑定的银行卡
    class func fetchCard(_ userId: Int, complete: @escaping (_ value: [BankModel]) -> Void) {
        
        request(fetchCardWithId + "\(userId)", type: .post) { (flag, value) in
            guard flag == true else {
                return
            }
            // 直接解析
            let json = JSON(value)
            printLog("获取银行卡信息---\(json)")
            let code = json["code"].intValue
            
            if code == 200 {
                var bankArray: [BankModel] = []
                let rows = json["rows"].arrayObject
                
                guard rows!.count > 0 else {
                    complete([])
                    return
                }
                
                for item in rows! {
                    let model = BankModel(dict: item as! [String: AnyObject])
                    bankArray.append(model)
                }
                complete(bankArray)
            }
        }
        
    }
    
}

// MARK: - 账户管理
extension NetworkTools {
    
    /// 获取验证吗
    class func fetchVerificationCode(_ tel: String, complete: @escaping (_ code: String) -> Void) {
        
        request(verificationCode + tel, type: .get) { (flag, value) in
            
            guard flag == true else {
                return
            }
            // 直接解析
            let json = JSON(value)
            printLog("获取验证吗---\(json)")
            let code = json["code"].intValue
            let rows = json["rows"].dictionaryObject
            
            if code == 200 {
                let verfication = rows!["verfication"] as! String
                complete(verfication)
            }
            
        }
    }
    
    /// 注册账号
    class func registerAccount(_ tel: String, complete: @escaping (_ flag: Bool, _ msg: String) -> Void) {
        
        request(register + tel, type: .get) { (flag, value) in
            guard flag == true else {
                return
            }
            
            // 直接解析
            let json = JSON(value)
            printLog("注册结果---\(json)")
            let code = json["code"].intValue
            let msg = json["msg"].stringValue
            
            if code == 200 {
                complete(true, msg)
            }else {
                complete(false, msg)
            }
        }
    }
    
    /// 账号登录
    class func loginAccount(_ tel: String, complete:@escaping (_ flag: Bool, _ value: String) -> Void) {
        
        request(login + tel, type: .get) { (flag, value) in
            guard flag == true else {
                return
            }
            
            // 直接解析
            let json = JSON(value)
            printLog("账号登录---\(json)")
            let code = json["code"].intValue
            let rows = json["rows"].dictionaryObject
            let msg = json["msg"].stringValue
            
            // 表示登录成功
            if code == 200 {
                let phone = rows!["customerTel"] as! String
                complete(true, phone)
            }
            
            // 表示该手机号没注册，我们先进行注册
            if code == 400 {
                complete(false, msg)
            }else {
                // 其他情况
                complete(false, msg)
            }
            
        }
        
    }
}
