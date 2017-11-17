//
//  AppDelegate.swift
//  Loan
//
//  Created by lau Andy on 2017/11/7.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit
import SwiftyJSON
import Meiqia
import Contacts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window?.backgroundColor = UIColor.white
        
        // 提前注册一个VersionCode 的 NSUserDefaults
        let dict: [String: Any] = [logigSuccess: false]
        UserDefaults.standard.register(defaults: dict)
        
        // 美洽客服服务
        MQManager.initWithAppkey("9b5a9b1b04601ad7a8a95715445025f7") { (clientId, error) in
            printLog("mieqia---\(String(describing: clientId))---\(String(describing: error))")
        }
        
        // 请求访问通讯录
        /// 第一次 先去请求访问通讯录
        CNContactStore().requestAccess(for: .contacts) { (isRight, error) in
            if isRight {
                // 授权成功
                printLog("请求授权成功")
            }else{
                printLog("请求授权失败")
            }
        }
        
        // 极光推送配置
        //通知类型（这里将声音、消息、提醒角标都给加上）
        let userSettings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
        JPUSHService.register(forRemoteNotificationTypes: userSettings.types.rawValue, categories: nil)
        
        // 启动JPushSDK
        JPUSHService.setup(withOption: nil, appKey: jpush_appKey, channel: jpush_channel, apsForProduction: false) // 是否为生产环境

        // 监听自定义消息
         NotificationCenter.default.addObserver(forName: Notification.Name.jpfNetworkDidReceiveMessage, object: nil, queue: OperationQueue.current) { (notification) in
            printLog("自定义消息通知-----\(String(describing: notification.userInfo))")
        }

        return true
    }
    
    /// 注册 deviceToken 成功
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        printLog("deviceToken------\(deviceToken)")
        JPUSHService.registerDeviceToken(deviceToken)
        
        printLog("registrationID------\(JPUSHService.registrationID())")
        
    }
    
    /// 注册 deviceToken 失败
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        printLog("注册deviceToken失败---------\(error.localizedDescription)")
    }
    
    /// 接收极光推送消息
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // 增加iOS 7 的支持
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
        
        printLog("推送消息------\(JSON(userInfo))")
        
        let value = JSON(userInfo)
        let aps = value["aps"].dictionaryValue
        let message = aps["alert"]!.stringValue
        
        printLog("推送的消息内容----\(String(describing: message))")
        
        //获取通知消息和自定义参数数据
//        let id = userInfo["id"] as! String
//        let time = userInfo["time"] as! String
//        let aps = userInfo["aps"] as! NSDictionary
//        let alert = aps["alert"] as! String

    }
    

    func applicationWillResignActive(_ application: UIApplication) {

        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    //App 进入后台时，关闭美洽服务
    func applicationDidEnterBackground(_ application: UIApplication) {
        MQManager.closeMeiqiaService()
    }

    //App 进入前台时，开启美洽服务
    func applicationWillEnterForeground(_ application: UIApplication) {
        MQManager.openMeiqiaService()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        JPUSHService.resetBadge()
        
        /// 取消app角标
        UIApplication.shared.applicationIconBadgeNumber = 0
        UIApplication.shared.cancelAllLocalNotifications()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

