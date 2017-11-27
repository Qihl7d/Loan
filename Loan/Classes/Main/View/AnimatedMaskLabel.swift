//
//  AnimatedMaskLabel.swift
//  Loan
//
//  Created by lau Andy on 2017/11/27.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

@IBDesignable
class AnimatedMaskLabel: UIView {
    
    let label: UILabel = {
        let lab = UILabel()
       
        return lab
    }()

    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        // Configure the gradient here
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        let colors = [
            UIColor.yellow.cgColor,
            UIColor.green.cgColor,
            UIColor.orange.cgColor,
            UIColor.cyan.cgColor,
            UIColor.red.cgColor,
            UIColor.yellow.cgColor
        ]
        gradientLayer.colors = colors
        
        let locations: [NSNumber] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
        
        gradientLayer.locations = locations
        
        return gradientLayer
    }()
    
    @IBInspectable var text: String! {
        didSet {

          
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.addSublayer(gradientLayer)
    }

}
