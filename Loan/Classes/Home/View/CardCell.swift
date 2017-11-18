//
//  CardCell.swift
//  Loan
//
//  Created by lau Andy on 2017/11/8.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {

    @IBOutlet weak var moneyLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cuttingCorner(radius: 10)
    }

}
