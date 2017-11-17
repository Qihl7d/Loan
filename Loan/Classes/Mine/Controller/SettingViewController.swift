//
//  SettingViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/16.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit
import UserNotifications
import MBProgressHUD

///  设置
class SettingViewController: UIViewController {

    
    @IBOutlet weak var navBarHeight: NSLayoutConstraint!
    
    /// 通知关闭按钮
    @IBOutlet weak var InfoSwitch: UISwitch!
    
    /// 现实版本号
    @IBOutlet weak var VersionLab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if IS_IPhone_X {
            navBarHeight.constant = 88
        }
        
        /// 判断是否开启推送通知
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    printLog("是否注册了远程推送----是")
//                    self.InfoSwitch.setOn(true, animated: true)
                }else {
                    printLog("是否注册了远程推送----没有")
//                    self.InfoSwitch.setOn(false, animated: true)
                }
            }
        } else {
            // Fallback on earlier versions
            let flag = UIApplication.shared.isRegisteredForRemoteNotifications
            printLog("是否注册了远程推送----\(flag == true ? "是" : "没有")")
            
            if flag {
//                self.InfoSwitch.setOn(true, animated: true)
            }else {
//                self.InfoSwitch.setOn(false, animated: true)
            }
            
        }
        
        //应用程序信息
        if let infoDictionary = Bundle.main.infoDictionary {
            let majorVersion = infoDictionary["CFBundleShortVersionString"]! //主程序版本号
            let minorVersion = infoDictionary["CFBundleVersion"]! //版本号（内部标示）
            
            VersionLab.text = "\(String(describing: majorVersion)).\(String(describing: minorVersion))"
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Action

    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    /// 消息通知
    @IBAction func msgNotificationAction(_ sender: UISwitch) {
        
        printLog("-------\(sender.isOn)")
        
        if sender.isOn {
            
            MBProgressHUD.showMessage("亲，您阔以接受消息推送服务了", toView: self.view)
//            InfoSwitch.setOn(false, animated: true)
            
        }else {
            MBProgressHUD.showMessage("亲，您将无法接受还款通知哦～", toView: self.view)
//            InfoSwitch.setOn(true, animated: true)
            
//            let alertController = UIAlertController(title: "关闭消息通知",
//                                                    message: "关闭后将无法收到还款通知、账户变动、精彩活动等消息推送",
//                                                    preferredStyle: .alert)
//
//            let cancelAction = UIAlertAction(title: "暂不关闭", style: .default, handler: { (action) in
//                self.InfoSwitch.setOn(true, animated: true)
//
//            })
//
//            let settingsAction = UIAlertAction(title:"仍然关闭", style: .default, handler: {
//                (action) -> Void in
//
//                self.InfoSwitch.setOn(false, animated: true)
//
//                let url = URL(string: UIApplicationOpenSettingsURLString)
//                if let url = url, UIApplication.shared.canOpenURL(url) {
//                    if #available(iOS 10, *) {
//                        UIApplication.shared.open(url, options: [:],
//                                                  completionHandler: {
//                                                    (success) in
//                        })
//                    } else {
//                        UIApplication.shared.openURL(url)
//                    }
//                }
//            })
//
//            alertController.addAction(cancelAction)
//            alertController.addAction(settingsAction)
//
//            self.present(alertController, animated: true, completion: nil)
//
//        }
  
        }

    }
}
