//
//  MBProgressHUD+HUD.swift
//  Loan
//
//  Created by lau Andy on 2017/11/15.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD {
    
    class func showMessage(_ mes: String, toView view: UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = mes
        hud.removeFromSuperViewOnHide = true  // 隐藏时候从父控件中移除
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    
}
