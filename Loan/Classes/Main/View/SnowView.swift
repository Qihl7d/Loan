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
        emitter.emitterPosition = CGPoint(x: frame.width/2, y: frame.height/2) // 决定了粒子发射形状的中心点
        emitter.emitterSize = bounds.size // 决定了粒子发射形状的大小
        emitter.emitterShape = kCAEmitterLayerRectangle // 粒子从什么形状发射出来，它并不是表示粒子自己的形状
        //emitter.emitterMode = kCAEmitterLayerPoints // 决定了粒子的发射模式
        
        //cell #1
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
        
        //cell #2
        let cell2 = CAEmitterCell()
        cell2.contents = UIImage(named: "flake2.png")?.cgImage
        cell2.birthRate = 50
        cell2.lifetime = 2.5
        cell2.lifetimeRange = 1.0
        cell2.yAcceleration = 50
        cell2.xAcceleration = 50
        cell2.velocity = 80
        cell2.emissionLongitude = .pi
        cell2.velocityRange = 20
        cell2.emissionRange = .pi * 0.25
        cell2.scale = 0.8
        cell2.scaleRange = 0.2
        cell2.scaleSpeed = -0.1
        cell2.alphaRange = 0.35
        cell2.alphaSpeed = -0.15
        cell2.spin = .pi
        cell2.spinRange = .pi
        
        //cell #3
        let cell3 = CAEmitterCell()
        cell3.contents = UIImage(named: "flake3.png")?.cgImage
        cell3.birthRate = 20
        cell3.lifetime = 7.5
        cell3.lifetimeRange = 1.0
        cell3.yAcceleration = 20
        cell3.xAcceleration = 10
        cell3.velocity = 40
        cell3.emissionLongitude = .pi
        cell3.velocityRange = 50
        cell3.emissionRange = .pi * 0.25
        cell3.scale = 0.8
        cell3.scaleRange = 0.2
        cell3.scaleSpeed = -0.05
        cell3.alphaRange = 0.5
        cell3.alphaSpeed = -0.05
        
        //cell #4
        let cell4 = CAEmitterCell()
        cell4.contents = UIImage(named: "flake4.png")?.cgImage
        cell4.birthRate = 20
        cell4.lifetime = 7.5
        cell4.lifetimeRange = 1.0
        cell4.yAcceleration = 20
        cell4.xAcceleration = 10
        cell4.velocity = 40
        cell4.emissionLongitude = .pi
        cell4.velocityRange = 50
        cell4.emissionRange = .pi * 0.25
        cell4.scale = 0.8
        cell4.scaleRange = 0.2
        cell4.scaleSpeed = -0.05
        cell4.alphaRange = 0.5
        cell4.alphaSpeed = -0.05

        emitter.emitterCells = [cell2,cell3,cell4]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
}
