//
//  AlertView.swift
//  TextDemo
//
//  Created by lau Andy on 2017/11/22.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

typealias AlertClickClosure = ((_ index: Int) -> Swift.Void)?

enum AlertAnimationOptions {
    case none
    case zoom         // 先放大，再缩小，在还原
    case topToCenter  // 从上到中间
}

class AlertView: UIView {

    private let screenWidth  = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    private let contentWidth:CGFloat  = 270.0
    private let contentHeight:CGFloat = 120.0
    
    private var effectView:UIVisualEffectView!
    private var contentView:UIView!
    
    private var selectClosure: AlertClickClosure
    private var msg: String!
    private var btnArr: [String] = [] // 只能有两种 -> 取消，取消和确定
    
    public var animationOption:AlertAnimationOptions = .zoom
    
    public var visual = false
    {
        didSet {
            if visual == false {
                effectView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            }else {
                effectView.backgroundColor = UIColor.clear
            }
        }
    }
    
    init(title: String, options: [String], selectBlock: ((_ index: Int) -> Swift.Void)?) {
        super.init(frame: UIScreen.main.bounds)
        
        self.msg = title
        self.btnArr = options
        self.selectClosure = selectBlock
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func show(title: String, options: [String], selectBlock: ((_ index: Int) -> Swift.Void)?) {
        AlertView(title: title, options: options, selectBlock: selectBlock).show()
    }

}

extension AlertView {
    
    fileprivate func setupUI() {
        
        /// 设置虚化背景
        effectView = UIVisualEffectView()
        effectView.frame = frame
        effectView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        effectView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        addSubview(effectView)
        
        /// 内容视图
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: contentWidth, height: contentHeight))
        contentView.center = CGPoint(x: screenWidth/2, y: screenHeight/2)
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin]
        addSubview(contentView)
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: contentWidth, height: 4))
        lineView.backgroundColor = rgb(66, 191, 255)
        contentView.addSubview(lineView)
        
        // 只有取消按钮
        if btnArr.count == 1 {
            
            let msgLab = UILabel(frame: CGRect(x: 0, y: 4, width: contentWidth, height: contentHeight-44))
            contentView.addSubview(msgLab)
            msgLab.text = msg
            msgLab.font = UIFont.systemFont(ofSize: 18)
            msgLab.textAlignment = .center
            msgLab.textColor = UIColor.black
            msgLab.numberOfLines = 0
            
            let cancel = button(frame: CGRect(x: 0, y: contentHeight-44, width: contentWidth, height: 44), title: "取消", target: self, action: #selector(cancelAction))
            contentView.addSubview(cancel)
            
        }else {
            
            let msgLab = UILabel(frame: CGRect(x: 15, y: 4, width: contentWidth - 30, height: contentHeight-44))
            contentView.addSubview(msgLab)
            msgLab.text = msg
            msgLab.font = UIFont.systemFont(ofSize: 18)
            msgLab.textAlignment = .center
            msgLab.textColor = UIColor.black
            msgLab.numberOfLines = 0
            
            let cancelBtn = button(frame: CGRect(x: 0, y: contentHeight-44, width: contentWidth/2, height: 44), title: btnArr[0], target: self, action: #selector(cancelAction))
            contentView.addSubview(cancelBtn)
            
            let sureBtn = button(frame: CGRect(x: contentWidth/2, y: contentHeight-44, width: contentWidth/2, height: 44), title: btnArr[1], target: self, action: #selector(sureAction))
            contentView.addSubview(sureBtn)
        }
        
        
    }
    
    
    @objc fileprivate func cancelAction() {
        
        if selectClosure != nil {
            selectClosure!(0)
        }
        
        dismiss()
    }
    
    @objc fileprivate func sureAction() {
        
        if selectClosure != nil {
            selectClosure!(1)
        }

        dismiss()
    }
    
    fileprivate func button(frame: CGRect, title: String, target: Any, action: Selector) -> UIButton {
        
        let btn = UIButton(type: .custom)
        btn.frame = frame
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        
        btn.setBackgroundImage(imageWithColor(color: rgb(235, 235, 235)), for: .highlighted)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        let lineUp = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 0.5))
        lineUp.backgroundColor = rgb(219, 219, 219)
        
        let lineRight = UIView(frame: CGRect(x: frame.size.width, y: 0, width: 0.5, height: frame.size.height))
        
        lineRight.backgroundColor = rgb(219, 219, 219)
        btn.addSubview(lineUp)
        btn.addSubview(lineRight)
        
        return btn
    }
    
    func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
    fileprivate func imageWithColor(color: UIColor) -> UIImage? {
        
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func show() {
        
        UIApplication.shared.keyWindow?.addSubview(self)
       
        switch animationOption {
        case .none:
            
            contentView.alpha = 0.0
            UIView.animate(withDuration: 0.35, animations: {
                self.contentView.alpha = 1.0
                
                if self.visual {
                   self.effectView.effect = UIBlurEffect(style: .dark) //模糊效果
                }
                
            })
        case .zoom:
       
            contentView.layer.setValue(0.8, forKeyPath: "transform.scale")
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                self.contentView.layer.setValue(1.0, forKeyPath: "transform.scale")
                if self.visual {
                    self.effectView.effect = UIBlurEffect(style: .dark) //模糊效果
                }
                
            }, completion: nil)
            
        case .topToCenter:
            let startPoint = CGPoint(x: center.x, y: contentView.frame.height)
            contentView.layer.position = startPoint
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                self.contentView.layer.position = self.center
                if self.visual {
                    self.effectView.effect = UIBlurEffect(style: .dark) //模糊效果
                }
            }, completion: nil)

        }
    }
    
    func dismiss() {
        
        switch animationOption {
        case .none:
            
            UIView.animate(withDuration: 0.35, animations: {
                self.contentView.alpha = 0.0
                self.effectView.alpha = 0.0
                if self.visual {
                    self.effectView.effect = nil
                }
            }, completion: { (_) in
                self.removeFromSuperview()
            })
            
        case .zoom:
            
            UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                self.contentView.alpha = 0.0
                self.effectView.alpha = 0.0
                if self.visual {
                    self.effectView.effect = nil
                }
            }, completion: { (_) in
                self.removeFromSuperview()
            })
            
        case .topToCenter:
            
            let endPoint = CGPoint(x: center.x, y: frame.height + contentView.frame.height)
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                self.contentView.layer.position = endPoint
                if self.visual {
                    self.effectView.effect = nil
                }
            }, completion: { (_) in
                self.removeFromSuperview()
            })
            
        }
    }
    
}
