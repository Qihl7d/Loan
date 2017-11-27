//
//  SnowView.swift
//  Loan
//
//  Created by lau Andy on 2017/11/27.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class SnowView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let emitter = layer as! CAEmitterLayer // 控制粒子发射位置和形状的属性
        emitter.emitterPosition = CGPoint(x: 0, y: 0) // 决定了粒子发射形状的中心点
        emitter.emitterSize = bounds.size // 决定了粒子发射形状的大小
        emitter.emitterShape = kCAEmitterLayerRectangle // 粒子从什么形状发射出来，它并不是表示粒子自己的形状
        //emitter.emitterMode = kCAEmitterLayerPoints // 决定了粒子的发射模式
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "flake.png")!.cgImage // 是个CGImageRef的对象,既粒子要展现的图片
        emitterCell.birthRate = 300  // 顾名思义没有这个也就没有emitterCell，这个必须要设置，具体含义是每秒某个点产生的effectCell数量
        emitterCell.lifetime = 3.5  // 表示emitterCell的生命周期，既在屏幕上的显示时间要多长
        emitterCell.color = UIColor.white.cgColor
        emitterCell.redRange = 0.0
        emitterCell.blueRange = 0.1
        emitterCell.greenRange = 0.0
        emitterCell.velocity = 5    // 表示cell向屏幕右边飞行的速度
        emitterCell.velocityRange = 350  // 在右边什么范围内飞行
        emitterCell.emissionRange = CGFloat(Double.pi/2) // 角度扩散
        emitterCell.emissionLongitude = CGFloat(-Double.pi) // x-y平面的发射方向
        emitterCell.yAcceleration = 70 // 粒子y方向的加速度分量
        emitterCell.xAcceleration = 0 // 粒子x方向的加速度分量
        emitterCell.scale = 0.33
        emitterCell.scaleRange = 1.25
        emitterCell.scaleSpeed = -0.25
        emitterCell.alphaRange = 0.9  // 一个粒子的颜色alpha能改变的范围
        emitterCell.alphaSpeed = 0.15  // 粒子透明度在生命周期内的改变速度
        
        emitter.emitterCells = [emitterCell]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
}
