//
//  UIView+Extension.swift
//  Loan
//
//  Created by lau Andy on 2017/11/7.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

extension Double{
    //保留几位小数字符串
    func string(_ dot:UInt)->String{
        return String(format: "%.\(dot)f", self)
    }
    var string:String{
        return String(format: "%f", self)
    }
    var float:Float{
        return Float(self)
    }
    var cgFloat:CGFloat{
        return CGFloat(self)
    }
    //    var to2Dot:Double{
    //        return (Double(Int(100*self))/100)
    //    }
    //
    //    var to4Dot:Double{
    //        return (Double(Int(10000*self))/10000)
    //    }
    //
    //    func toDot(_ dot:UInt) -> Double {
    //        let dotN = pow(10.0, Double(dot))
    //        return (Double(Int(dotN*self))/dotN)
    //    }
}

extension Float{
    //保留几位小数字符串
    
    func string(_ dot: UInt) -> String {
        return String(format: "%.\(dot)f", self)
    }
    var string: String {
        return String(format: "%f", self)
    }
    var double: Double {
        return Double(self)
    }
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    //    var to2Dot: Float {
    //        return (Float(Int(100*self))/100)
    //    }
    //
    //    var to4Dot: Float {
    //        return (Float(Int(10000*self))/10000)
    //    }
    //
    //    func toDot(_ dot:UInt) -> Float {
    //        let dotN = pow(10.0, Float(dot))
    //        return (Float(Int(dotN*self))/dotN)
    //    }
}

extension CGFloat {
    //保留几位小数字符串
    func string(_ dot: UInt) -> String{
        return String(format: "%.\(dot)f", self)
    }
    var string: String {
        return String(format: "%f", self)
    }
    
    var double: Double {
        return Double(self)
    }
    var float: Float {
        return Float(self)
    }
    
    //    var to2Dot: CGFloat {
    //        return (CGFloat(Int(100*self))/100)
    //    }
    //
    //    var to4Dot:CGFloat {
    //        return (CGFloat(Int(10000*self))/10000)
    //    }
    //
    //    func toDot(_ dot:UInt) -> CGFloat {
    //        let dotN = pow(10.0, CGFloat(dot))
    //        return (CGFloat(Int(dotN*self))/dotN)
    //    }
}

extension Int{
    //保留几位小数字符串
    func string(_ dot: UInt) -> String{
        var str = ""
        if dot > 0{
            str = "."
            for _ in 1...dot{
                str += "0"
            }
        }
        return String(format: "%d", self)+str
    }
    var string: String{
        return String(format: "%d", self)
    }
    var double: Double{
        return Double(self)
    }
    var float: Float{
        return Float(self)
    }
    var cgFloat:CGFloat{
        return CGFloat(self)
    }
}

extension UIView {
    
    // 砌圆角
    func cuttingCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func setupBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    /// x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
}

//抖动方向枚举
public enum ShakeDirection: Int {
    case horizontal  //水平抖动
    case vertical  //垂直抖动
}

extension UIView {
    
    /**
     扩展UIView增加抖动方法
     
     @param direction：抖动方向（默认是水平方向）
     @param times：抖动次数（默认5次）
     @param interval：每次抖动时间（默认0.1秒）
     @param delta：抖动偏移量（默认2）
     @param completion：抖动动画结束后的回调
     
     */
    public func shake(direction: ShakeDirection = .horizontal, times: Int = 5,
                      interval: TimeInterval = 0.1, delta: CGFloat = 2,
                      completion: (() -> Void)? = nil) {
        //播放动画
        UIView.animate(withDuration: interval, animations: { () -> Void in
            switch direction {
            case .horizontal:
                self.layer.setAffineTransform( CGAffineTransform(translationX: delta, y: 0))
                break
            case .vertical:
                self.layer.setAffineTransform( CGAffineTransform(translationX: 0, y: delta))
                break
            }
        }) { (complete) -> Void in
            //如果当前是最后一次抖动，则将位置还原，并调用完成回调函数
            if (times == 0) {
                UIView.animate(withDuration: interval, animations: { () -> Void in
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) -> Void in
                    completion?()
                })
            }
                //如果当前不是最后一次抖动，则继续播放动画（总次数减1，偏移位置变成相反的）
            else {
                self.shake(direction: direction, times: times - 1,  interval: interval,
                           delta: delta * -1, completion:completion)
            }
        }
    }
}
