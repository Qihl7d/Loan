//
//  MotionView.swift
//  Loan
//
//  Created by lau Andy on 2017/11/27.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit
import CoreMotion

class MotionView: UIView {
    
    private let imageSize: CGSize = CGSize(width: 35, height: 35)
    
    init(frame: CGRect, imageArr: [String]) {
        super.init(frame: frame)
        
        for i in 0..<imageArr.count {
            
            let imgNum = frame.size.width/imageSize.width
            let imgRect = CGRect(x: imageSize.width * (CGFloat(i).truncatingRemainder(dividingBy: imgNum)), y: imageSize.height * (CGFloat(i)/imgNum), width: imageSize.width, height: imageSize.height)
            
            let motionImg = MotionImageView(frame: imgRect, imageName: imageArr[i])
            self.addSubview(motionImg)
            
            // 加入重力感应和加速计
            addAnimateView(animate: motionImg)
  
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载
    
    /// 运动管理者
    lazy var manager: CMMotionManager = {
        return CMMotionManager()
    }()
    
    /// 物理行为（动态媒介）
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self)
    }()
    
    /// 重力行为
    lazy var gravity: UIGravityBehavior = {
        let gravity = UIGravityBehavior()
        self.animator.addBehavior(gravity)
        
        return gravity
    }()
    
    ///  碰撞行为
    lazy var collision: UICollisionBehavior = {
        let collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        /**
         collisionMode: 碰撞模式
         《1》UICollisionBehaviorModeItems 元素碰撞
         《2》UICollisionBehaviorModeBoundaries 边境碰撞
         《3》UICollisionBehaviorModeEverything 所有都可以碰撞
         */
        collision.collisionMode = UICollisionBehaviorMode.everything
        self.animator.addBehavior(collision)
        return collision
    }()
    
    /// 动力学属性
    lazy var dynamic: UIDynamicItemBehavior = {
        
        let dynamic = UIDynamicItemBehavior()
        dynamic.friction = 0.2 /// 摩擦力系数
        dynamic.elasticity = 0.8 /// 弹性系数 在0~1之间
        dynamic.density = 0.2 /// 跟size大小相关，计算物体块的质量
        dynamic.allowsRotation = true /// 是否能旋转
        dynamic.resistance = 0 /// 阻力系数
        self.animator.addBehavior(dynamic)
        return dynamic
    }()
    
    public func addAnimateView(animate: UIView) {
        
        self.dynamic.addItem(animate)
        self.collision.addItem(animate)
        self.gravity.addItem(animate)
        
        self.manager.deviceMotionUpdateInterval = 0.01

        self.manager.startDeviceMotionUpdates(to: OperationQueue.main) { [weak self] (motion, error) in
            if error != nil {
                debugPrint("滚动小球出错了---\(error.debugDescription)")
                return
            }
            
            if motion != nil {
              self?.gravity.gravityDirection = CGVector(dx: motion!.gravity.x * 3, dy: -motion!.gravity.y * 3)
            }
  
        }
    }
    
    public func stopMotion() {
        if self.manager.isDeviceMotionActive {
            self.manager.stopDeviceMotionUpdates()
            self.animator.removeAllBehaviors()
        }
    }
    
}

class MotionImageView: UIImageView {
    
    init(frame: CGRect, imageName: String) {
        super.init(frame: frame)
        
        self.image = UIImage(named: imageName)
        self.layer.cornerRadius = frame.size.width/2
        self.layer.masksToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     在UIDynamicItemGroup类中，有一个collisionBoundsType的属性，可以修改属性值，进而修改控件的碰撞边缘。但这个属性是只读的，所以需要创建一个继承自UIView的类，改写这个属性
     */
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return UIDynamicItemCollisionBoundsType.ellipse
    }
    
}
