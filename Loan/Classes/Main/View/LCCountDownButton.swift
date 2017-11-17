//
//  LCCountDownButton.swift
//  Loan
//
//  Created by lau Andy on 2017/11/7.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class LCCountDownButton: UIButton {
//    
//    // 定义需要计时的时间
//    var timeCount = 60
//    
//    // 在global线程里创建一个时间源
//    var codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
//    // 设定这个时间源是每秒循环一次，立即开始
//    //    codeTimer.scheduleRepeating(deadline: .now(), interval: .seconds(1))
//    // 设定时间源的触发事件
//    codeTimer.setEventHandler(handler: {
//    // 每秒计时一次
//    timeCount = timeCount - 1
//    // 时间到了取消时间源
//    if timeCount <= 0 {
//    codeTimer.cancel()
//    }
//    // 返回主线程处理一些事件，更新UI等等
//    DispatchQueue.main.async {
//    }
//    })
//    // 启动时间源
//    codeTimer.resume()
    
    
    //        let acVC = LCActionSheetController(cellTitleList: ["保存", "收藏", "分享", "点赞"])!
    //        acVC.valueBlock = { index in
    //            acVC.sheetViewDismiss()
    //            print(index)
    //        }
    //        acVC.cellTitleColor = UIColor.red
    //        acVC.cellTitleFont = 17
    //        acVC.titleString = "当你弹出来时，我love你"
    //
    //        present(acVC, animated: false, completion:  nil)
    
    //        //获取系统存在的全局队列
    //        let queue = DispatchQueue.global(qos: .default)
    //        //定义一个group
    //        let group = DispatchGroup()
    //        //并发任务，顺序执行
    //        queue.async(group: group) {
    //            sleep(2)
    //            print("block1")
    //        }
    //        queue.async(group: group) {
    //            sleep(4)
    //            print("block2")
    //        }
    //        queue.async(group: group) {
    //            sleep(3)
    //            print("block3")
    //        }
    //
    //        //1,所有任务执行结束汇总，不阻塞当前线程
    //        group.notify(queue: .global(), execute: {
    //            print("group done")
    //        })
    //
    //        //2,永久等待，直到所有任务执行结束，中途不能取消，阻塞当前线程
    //        group.wait()
    //        print("任务全部执行完成")
    
    //        //创建串行队列
    //        let serial = DispatchQueue(label: "serialQueue1")
    //
    //        //创建并行队列
    //        let concurrent = DispatchQueue(label: "concurrentQueue1", attributes: .concurrent)
}
