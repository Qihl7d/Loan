//
//  Const.swift
//  Loan
//
//  Created by lau Andy on 2017/11/7.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 全局常量
let kStaBar_h: CGFloat = 20.0
let kNavBar_h: CGFloat = 44.0
let kTabBar_h: CGFloat = 49.0

let keyView = UIApplication.shared.keyWindow!
let kScreen_w = UIScreen.main.bounds.size.width
let kScreen_h = UIScreen.main.bounds.size.height

/*
   宽高比：
 
           5s -->  320/568 = 0.5633
     6/6s/7/8 -->  375/667 = 0.5622
 6p/6sp/7p/8p -->  414/736 = 0.5625
     iphone_x -->  375/812 = 0.4618
 
 // 类：具有相同特征和行为的事物的抽象集合
 // 对象：是类里面的具体某个实例
 
 */

/*
 convenience:便利，使用convenience修饰的构造函数叫做便利构造函数
 便利构造函数通常用在对系统的类进行构造函数的扩充时使用。
 便利构造函数的特点：
 1、便利构造函数通常都是写在extension里面
 2、便利函数init前面需要加载convenience
 3、在便利构造函数中需要明确的调用self.init()
 
 */ 


/// 设计屏幕适配
let IS_IPhone5_5s:         Bool = kScreen_h == 568 ? true : false
let IS_IPhone6_6s_7_8:     Bool = kScreen_h == 667 ? true : false
let IS_IPhone6p_6sp_7p_8p: Bool = kScreen_h == 736 ? true : false
let IS_IPhone_X:           Bool = kScreen_h == 812 ? true : false

// MARK: - 自定义方法
func printLog<T>(_ message: T,logError: Bool = false,file: String = #file,method: String = #function,line: Int = #line) {
    if logError{
        print("[\((file as NSString).lastPathComponent)-第\(line)行-\(method)]: \(message)")
    }else{
        #if DEBUG
            print("[\((file as NSString).lastPathComponent)-第\(line)行-\(method)]: \(message)")
        #endif
    }
}

/// 判断用户是否登录(登录状态，手就号码，用户id)
func isLogin() -> (Bool, phone: String, customId: String) {
    
    let customid = UserDefaults.standard.string(forKey: customId)
    let isLogin  = UserDefaults.standard.string(forKey: logigSuccess)
    
    if isLogin != "0" { // 表示已经登录
        return (true, isLogin!, customid!)
    }else {
        return (false, "","")
    }
}

/// 跳转登录界面登录
func persentLogin(_ vc: UIViewController) {
    let loginNav = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginNavigationController") as! UINavigationController
    _ = loginNav.viewControllers[0] as! LoginViewController
    vc.present(loginNav, animated: true, completion: nil)
}

// MARK: - 局部常量

/// 根url地址
let baseUrl = "http://116.62.218.101:8080/parent/"
///  极光推送appkey
let jpush_appKey = "e339251b5ef4bdfa8fa53cd1"
/// 发布渠道
let jpush_channel = "Publish Channel"

/// 登录成功
let logigSuccess = "logigSuccess"
/// 客服id
let customId = "customId"


//------------- 客户账号管理 -------------//

/// 获取验证吗
let verificationCode = baseUrl + "customerAccount/getVerificationCode/"
/// 客户登录
let login = baseUrl + "customerAccount/login/"
/// 客户注册
let register = baseUrl + "customerInfo/customerInfoRegister/"

//------------- 客户银行卡信息 -------------//

/// 绑定银行卡
let bindingBandCard = baseUrl + "customerBankCard/addCustomerBankCard"
/// 根据客户id，获取其绑定的银行卡
let fetchCardWithId = baseUrl + "customerBankCard/findBycustomerId?customerId="

//------------- 客户通讯录信息 -------------//

/// 保存客户通讯录信息
let saveAddressList = baseUrl + "customerAddressList/addCustomerAddressList"

//------------- 客户认证信息 -------------//

/// 所有认证信息保存
let saveApproveInfo = baseUrl + "customerInfo/addAuthentication"
/// 信用额度查询
let fetchCreditPoints = baseUrl + "customerInfo/getAuthenticationInfo/"
/// 电话认证
let phoneApprove = baseUrl + "customerInfo/telephoneAuthentication"

//------------- 客户基本信息管理 -------------//

/// 根据客户电话号码获取客户基本信息
let fetchBaseInfo = baseUrl + "customerInfo/findByCustomerTel/"
/// 借款首页和我的 公用接口
let fetchHomeInfo = baseUrl + "customerInfo/homePage/"

//------------- 客户订单信息 -------------//

/// 申请借款信息
let applyLoanInfo = baseUrl + "customerOrder/addOrder"
/// 还款界面信息
let repayInfo = baseUrl + "customerOrder/repaymentInterface/"
/// 根据客户id查看借款记录
let loadRecordInfo = baseUrl + "customerOrder/repaymentRecord/"
/// 根据订单编号查看借款详情(还款时间为空则表示已经还款)
let loadDetailInfo = baseUrl + "customerOrder/findCustomerOrderByOrderNum/"

