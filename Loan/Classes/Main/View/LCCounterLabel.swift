//
//  LCCounterLabel.swift
//  Loan
//
//  Created by lau Andy on 2017/11/7.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

enum LCAnimationType {
    case Int
    case Float
}

@IBDesignable class LCCounterLabel: UILabel {

    ///计时器比 NSTimer精确
    var timer:CADisplayLink!
    
    ///进程戳 从开始计时到实时的时间戳 后面会与传进来的最长时间对比
    var progress:TimeInterval!
    
    ///最后一次记录时间戳
    var lastupdate:TimeInterval!
    ///多长时间完成的参数
    var totalupdate:TimeInterval!
    
    ///最开始的计数
    var startValue:Float!
    ///将要结束的参数
    var endValue:Float!
    
    ///想要以Int类型 还是Float类型增长
    var type:LCAnimationType!
    
    var newText:String{
        get {
            return updateNewinfo()
        }
    }
    
    init(frame: CGRect, type:LCAnimationType) {
        super.init(frame: frame)
        self.type = type
    }
    
    func initCadisplayLink() {
        progress = 0
        timer = CADisplayLink(target: self, selector: #selector(timerclick(sender:)))
        timer.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func timerclick(sender:CADisplayLink) {

        /// 当执行这个方法时候 判断当前时间戳与 lastupdate这个参数的差 直到 将其相加 直到与 totalupdate 相等时 即为消耗了等量时间 此时强行将text职位endvalue
        
        ///记录当前时间戳
        let now:TimeInterval = NSDate.timeIntervalSinceReferenceDate
        ///当前时间 减去 开始事件
        progress = now - lastupdate
        
        if (now - lastupdate) >= totalupdate {
            progress = totalupdate
            stopLoop()
        }
        
        let text = newText
        self.text = text
    }
    
    func updateNewinfo() -> String {
        
        ///当前时间/总共所需要时间，来判断应该尽到哪里(肯定不会大于1)
        let timebi:Float = Float(progress)/Float(totalupdate)
        let updateVal = startValue + (timebi * (self.endValue - self.startValue))
        if type == LCAnimationType.Float {
            return String(format: "%.2f",updateVal)
        }
        return String(format: "%.0f",updateVal)
    }
    
    func countFrom(start:Float,to:Float,duration:TimeInterval) {
        ///将计时器销毁再重新生成
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
        
        ///记录时间戳
        lastupdate = NSDate.timeIntervalSinceReferenceDate
        
        ///耗时时间戳
        totalupdate = duration
        
        ///将其赋值
        startValue = start
        endValue = to
        
        initCadisplayLink()
    }
    
    ///销毁计时器
    func stopLoop() {
        timer.invalidate()
        timer = nil
    }

}
