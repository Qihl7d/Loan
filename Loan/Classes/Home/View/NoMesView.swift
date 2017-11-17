//
//  NoMesView.swift
//  Loan
//
//  Created by lau Andy on 2017/11/16.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class NoMesView: UIView {

    class func noMsgView() -> NoMesView {
       return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! NoMesView
    }

}
