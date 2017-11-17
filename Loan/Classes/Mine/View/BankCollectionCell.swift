//
//  BankCollectionCell.swift
//  Loan
//
//  Created by lau Andy on 2017/11/14.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class BankCollectionCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cuttingCorner(radius: 8)
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
}
