//
//  LayView.swift
//  TextDemo
//
//  Created by lau Andy on 2017/11/20.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class LayView: UIView {
    
    var strokeColor: UIColor = UIColor.white
    var strokeWidth: CGFloat = 5
    
    //将角度转为弧度
    func angleToRadian(_ angle: Double)->CGFloat {
        return CGFloat(angle/Double(180.0) * Double.pi)
    }
    // 角度转弧度
    var startAngle = CGFloat(135.0/180.0*Double.pi)  //外圈（底色圈）开始位置
    var endAngle = CGFloat(45.0/180.0*Double.pi)     //外圈（底色圈）结束位置
    var animEnd = CGFloat(0/180.0*Double.pi)     //外圈（底色圈）结束位置
    
    var progressLayer: CAShapeLayer! // 外圈进度条
    var dottedLayer: CAShapeLayer! // 虚线
    var arrowLayer: CAShapeLayer!  // 箭头动画layer
    var iamgeView: UIImageView! // 外圈亮点光标
    var arrowImage: UIImageView! // 箭头img
    
    var duration: Double = 1.5  // 动画时长
    
    struct Constant {
        //进度条宽度
        static let lineWidth: CGFloat = 10
        //进度槽颜色
        static let trackColor = UIColor.white.withAlphaComponent(0.4) //灰暗颜色
        //进度条颜色
        static let progressColoar = UIColor.white.withAlphaComponent(0.7) //高亮颜色

    }
    
    init(frame: CGRect, endAngle: CGFloat) {
        super.init(frame: frame)
        self.animEnd = endAngle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {

        /// 进度槽
        let trackLayer = DarwArcLayer(color: Constant.trackColor, lineWidth: 2, center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 75, startAngle: startAngle, endAngle: endAngle)
        layer.addSublayer(trackLayer)
        
        /// 进度条
        progressLayer = DarwArcLayer(color: Constant.progressColoar, lineWidth: 3, center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 75, startAngle: startAngle, endAngle: animEnd)
        layer.addSublayer(progressLayer)
        
        /// 绘制底层虚线
        let dotLayer = CAShapeLayer()
        dotLayer.lineCap = kCALineCapRound
        dotLayer.fillColor = UIColor.clear.cgColor
        dotLayer.strokeColor = Constant.trackColor.cgColor
        dotLayer.lineWidth = 2
        dotLayer.lineDashPhase = 0
        // 线的宽度 每条线的间距
        dotLayer.lineDashPattern = [NSNumber(value: 1), NSNumber(value: 4)]
        
        let p = CGMutablePath()
        p.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 70, startAngle: startAngle, endAngle: CGFloat(46/180.0*Double.pi), clockwise: false)
        dotLayer.path = p
        layer.addSublayer(dotLayer)
        
        /// 绘制动画虚线
        dottedLayer = CAShapeLayer()
        dottedLayer.lineCap = kCALineCapRound
        dottedLayer.fillColor = UIColor.clear.cgColor
        dottedLayer.strokeColor = Constant.progressColoar.cgColor
        dottedLayer.lineWidth = 2
        dottedLayer.lineDashPhase = 0
        // 3=线的宽度 1=每条线的间距
        dottedLayer.lineDashPattern = [NSNumber(value: 1), NSNumber(value: 4)]
        
        let animPath = CGMutablePath()
        animPath.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 70, startAngle: startAngle, endAngle: CGFloat(20/180.0*Double.pi)  , clockwise: false)
        dottedLayer.path = animPath
        layer.addSublayer(dottedLayer)
        
    }
    
    func setAnimated() {
        
        setupUI()
        
        /// 如果存在 就先移除后在动画
//        if iamgeView != nil {
//            iamgeView.removeFromSuperview()
//        }
//        
//        if arrowImage != nil {
//            arrowImage.removeFromSuperview()
//        }
        
        // 外圈(显色圈)动画
        let animation=CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fromValue = 0
        animation.toValue = 1
        animation.autoreverses = false
        animation.fillMode=kCAFillModeForwards
        progressLayer.add(animation, forKey: "strokeEndAnimation")
        
        // 虚线动画
        dottedLayer.add(animation, forKey: "strokeEndAnimation")
        
        // 光标动画
        let path: UIBezierPath = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 75, startAngle: startAngle, endAngle: animEnd, clockwise: true)

        let orbit1 = CAKeyframeAnimation(keyPath:"position")
        orbit1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        orbit1.calculationMode = kCAAnimationPaced // 我理解为节奏
        orbit1.fillMode = kCAFillModeForwards
        orbit1.rotationMode = kCAAnimationRotateAuto  // 根据路径自动旋转
        orbit1.isRemovedOnCompletion = false  // 是否在动画完成后从 Layer 层上移除  回到最开始状态
        orbit1.duration = duration
        orbit1.path = path.cgPath

        /// 光标
        iamgeView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        iamgeView.image = UIImage(named: "credit_hight") //credit_hight  credit_location
        self.addSubview(iamgeView)
        iamgeView.layer.add(orbit1, forKey: "transform.rotation.z")
        
        /// 箭头动画
        let arrowPath: UIBezierPath = UIBezierPath()
        arrowPath.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 60, startAngle: startAngle, endAngle: animEnd, clockwise: true)
        
        let arrowOrbit = CAKeyframeAnimation(keyPath:"position")
        arrowOrbit.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        arrowOrbit.calculationMode = kCAAnimationPaced // 我理解为节奏
        arrowOrbit.fillMode = kCAFillModeForwards
        arrowOrbit.rotationMode = kCAAnimationRotateAuto  // 根据路径自动旋转
        arrowOrbit.isRemovedOnCompletion = false  // 是否在动画完成后从 Layer 层上移除  回到最开始状态
        arrowOrbit.duration = duration
        arrowOrbit.path = arrowPath.cgPath
        
        arrowImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 18/2, height: 28/2))
        arrowImage.image = UIImage(named: "credit_location-1") //credit_hight  credit_location
        self.addSubview(arrowImage)
        arrowImage.layer.add(arrowOrbit, forKey: nil)
    }

    /**绘制弧线layer，默认顺时针方向绘制*/
    func DarwArcLayer(color: UIColor?, lineWidth: CGFloat, center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockWise: Bool = true) -> CAShapeLayer {
        //layer
        let pathLayer: CAShapeLayer = CAShapeLayer()
        pathLayer.lineCap = kCALineCapRound
        pathLayer.fillColor = UIColor.clear.cgColor
        if let color = color {
            pathLayer.strokeColor = color.cgColor
        }
        pathLayer.lineWidth = lineWidth
        pathLayer.strokeStart = 0.0
        pathLayer.strokeEnd = 1.0
        pathLayer.backgroundColor = UIColor.clear.cgColor
        //path
        let path: UIBezierPath = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockWise)
        path.stroke()
        pathLayer.path = path.cgPath
        return pathLayer
    }
  
}
