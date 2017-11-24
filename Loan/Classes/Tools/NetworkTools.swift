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
    
    /// 根据订单编号查看借款记录详情（还款时间为空则表示已经还款）
    class func fetchRepayRecord(_ orderNun: String, complete: @escaping (_ value: CustomerOrder) -> Void) {
        request(loadDetailInfo + orderNun, type: .post) { (flag, result) in
            guard flag == true else {
                return
            }
            
            // 直接解析
            let json = JSON(result)
            printLog("根据订单编号查看借款记录详情---\(json)")
            let isSuccess = json["isSuccess"].boolValue
            let rows = json["rows"].dictionaryObject
            
            if isSuccess {
                
                if let row = rows {
                    
                    let model = CustomerOrder() // 订单详情
                    
                    model.id = row["id"] as? Int
                    model.orderNum = row["orderNum"] as? String
                    model.applyByStagesTime = row["applyByStagesTime"] as? String
                    model.serviceCharge = row["serviceCharge"] as? Float
                    model.numberOfPeriods = row["numberOfPeriods"] as? Int
                    model.isByStages = row["isByStages"] as? Bool
                    model.loanAmount = row["loanAmount"] as? Float
                 // model.customerId = rows!["customerId"] as? Int // 涉及紧急人联系方式
                    // 是否删除
                    model.termOfLoan = row["termOfLoan"] as? Int
                    model.createTime = row["createTime"] as? String
                    model.repaymentAmount = row["repaymentAmount"] as? Float
                    model.returnAmount = row["returnAmount"] as? Float
                    model.orderState = row["orderState"] as? Int
                    model.updateTime = row["updateTime"] as? String
                    
                    /// 账单详情列表
                    let customerOrderDetails  = row["customerOrderDetails"] as? [[String: Any]] // 字典数组
                    
                    if let customOrder = customerOrderDetails {
                     
                        if customOrder.count > 0 {
                            
                            var orderDetails = [CustomerOrderDetails]()
                            
                            for item in customOrder {
                                
                                let detailModel = CustomerOrderDetails()
                                detailModel.id = item["id"] as? Int
                                detailModel.orderNum = item["orderNum"] as? String
                                detailModel.serviceFeePerTerm = item["serviceFeePerTerm"] as? Float
                                detailModel.repaymentTimeOfEachPeriod = item["repaymentTimeOfEachPeriod"] as? String
                                detailModel.numberOfPeriods = item["numberOfPeriods"] as? Int
                                detailModel.repaymentState = item["repaymentState"] as? Int
                                detailModel.overdueMoney = item["overdueMoney"] as? Float
                                detailModel.repaymentTime = item["repaymentTime"] as? String
                                detailModel.createTime = item["createTime"] as? String
                                detailModel.tradeNo = item["tradeNo"] as? String
                                detailModel.amountOfRepaymentPerInstalment = item["amountOfRepaymentPerInstalment"] as? Float
                                detailModel.isOverdue = item["isOverdue"] as? Bool
                                detailModel.updateTime = item["updateTime"] as? String
                                
                                orderDetails.append(detailModel)
                            }
                            
                            model.customerOrderDetails = orderDetails
                            
                        }else {
                            model.customerOrderDetails = []
                        }
                        
                    }
                    complete(model)
                }
            }
        }
    }
    
    /// 根据客户id查看借款记录
    class func fetchRepayLocord(_ customerId: Int, complete: @escaping (_ value: [RepayModel]) -> Void) {
        request(loadRecordInfo + "\(customerId)", type: .post) { (flag, result) in
            guard flag == true else {
                return
            }
            
            // 直接解析
            let json = JSON(result)
            printLog("根据客户id查看借款记录---\(json)")
            let isSuccess = json["isSuccess"].boolValue
            let rows = json["rows"].arrayObject
            
            if isSuccess {
                
                if let data = rows {
                    
                    var repayArray = [RepayModel]()
                    guard data.count > 0 else {
                        complete(repayArray)
                        return
                    }
                    
                    for item in data {
                        let model = RepayModel(dict: item as! [String: AnyObject])
                        repayArray.append(model)
                    }
                    complete(repayArray)
                }
            }
            
        }
    }
    
    /// 申请借款信息
    class func applyLoadInfo(_ params: [String: Any], complete: @escaping (_ value: Bool) -> Void) {
        
        var param = [String: Any]()
        param["customerId"] = "2"  // 客户id string
        param["loanAmount"] = 500  // 借款金额 double
        param["termOfLoan"] = "7天" // 借款期限 string
        param["isByStages"] = false // 是否分期
        param["numberOfPeriods"] = 3 // 分期周期 int
        param["applyByStagesTime"] = "date-time" // 申请分期时间
        
        request(applyLoanInfo, type: .post) { (flag, result) in
            guard flag == true else {
                return
            }
            
            // 直接解析
            let json = JSON(result)
            printLog("申请借款信息---\(json)")
            let isSuccess = json["isSuccess"].boolValue
            let rows = json["rows"].dictionaryObject
            
            if isSuccess {
                complete(true)
            }else{
                complete(false)
            }
        }
    }
    
    /// 还款界面(获取本期该还款多少)
    class func repayAmount(_ customerId: Int, complete: @escaping (_ value: Float) -> Void) {
        
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
                let model = data["repaymentAggregateMoney"] as! Float
                complete(model)
            }
        }
        
    }
 
}

// MARK: -客服基本信息管理
extension NetworkTools {
    
    /// 根据客户电话号码获取客户基本信息
    class func fetchCustomerInfo(_ tel: String, complete: @escaping (_ value: HomeModel) -> Void) {
        
    }
    
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
                // 可选绑定
                if let dict  = rows {
                    let model = CreditModel(dict: dict as [String: AnyObject])
                    complete(model)
                }
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
                if let dict = rows {
                    let customId = dict["id"] as! Int // 客服id
                    complete(true, "\(customId)")
                }
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
