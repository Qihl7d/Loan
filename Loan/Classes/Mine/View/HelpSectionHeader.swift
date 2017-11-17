//
//  HelpSectionHeader.swift
//  Loan
//
//  Created by lau Andy on 2017/11/11.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class HelpSectionHeader: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var spreadBtn: UIButton!
    
    typealias callBackBlock = (_ index : NSInteger,_ isSelected : Bool)->()
    
    var spreadBlock : callBackBlock!
    var isSelect: Bool = false
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        awakeFromNib()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let subView : UIView = Bundle.main.loadNibNamed("HelpSectionHeader", owner: self, options: nil)?.first as! UIView
//        subView.frame = self.frame
//        self.addSubview(subView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapAction() {
        isSelect = !isSelect
        if let _ = spreadBlock{
            spreadBlock(self.tag,isSelect)
        }
    }
    
}
