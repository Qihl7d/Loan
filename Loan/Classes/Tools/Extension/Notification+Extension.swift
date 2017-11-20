//
//  Notification+Extension.swift
//  Loan
//
//  Created by lau Andy on 2017/11/7.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import Foundation

/// 通知的高级用法

extension  Notification.Name {
    public struct Key {
        public static let xxx = "xxx"
    }
}

extension Notification.Name {
    public struct Task {
        public static let loginSuccess = Notification.Name(rawValue: "loginSuccess")
    }
    
    
    /*
     example:
     
     NotificationCenter.default.post(name: Notification.Name.Task.xxx,
                                     object: nil,
                                     userInfo: [Notification.Key.Task: task])
     
     
     */
}
