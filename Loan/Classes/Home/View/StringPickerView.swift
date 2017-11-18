//
//  StringPickerView.swift
//  Loan
//
//  Created by lau Andy on 2017/11/17.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class StringPickerView: UIView {

    fileprivate var coverView: UIView!
    fileprivate var contentView: UIView!
    fileprivate var pickView: UIPickerView!
    fileprivate var contentHeight: CGFloat = 250
    fileprivate var titleString: String?
    fileprivate var dataArray: [String] = []
    fileprivate var selectIndex: Int = 0 // 选择的是第几个
    
    typealias selectBlock = ((_ str: String) -> Swift.Void)?
    
    fileprivate var selectCallBlock:selectBlock
    
    
    init(frame: CGRect, title: String? = nil, dataArray: [String], selectBlock: selectBlock) {
        super.init(frame: frame)
        self.titleString = title != nil ? title : ""
        self.dataArray = dataArray
        self.selectCallBlock = selectBlock
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func show(_ title: String? = nil, dataArray: [String], selectBlock: selectBlock) {
        StringPickerView(frame: UIScreen.main.bounds, title: title, dataArray: dataArray, selectBlock: selectBlock).show()
    }
    
}

extension StringPickerView {
    
    fileprivate func setupUI() {
        // 设置背景
        coverView = UIView(frame: self.bounds)
        coverView.backgroundColor = UIColor.black
        coverView.alpha = 0.0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        coverView.addGestureRecognizer(tap)
        addSubview(coverView)
        
        // 内容
        contentView = UIView(frame: CGRect(x: 0, y: frame.height, width: frame.width, height: contentHeight))
        contentView.backgroundColor = UIColor.groupTableViewBackground
        addSubview(contentView)
        
        // 取消和确定
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: kScreen_w, height: 50))
        topView.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        contentView.addSubview(topView)
        
        // 设置阴影
        topView.layer.shadowColor = UIColor.black.cgColor
        topView.layer.shadowOffset = CGSize(width: 0, height: 0)
        topView.layer.shadowRadius = 5.0
        topView.layer.shadowOpacity = 0.3
        
        let titleLab = UILabel(frame: CGRect(x: 0, y: 0, width: kScreen_w-150, height: 20))
        topView.addSubview(titleLab)
        titleLab.text = titleString
        titleLab.textAlignment = .center
        titleLab.center = topView.center
        titleLab.font = UIFont.systemFont(ofSize: 13)
        titleLab.textColor = UIColor(hexString: "508fcd")
        
        // 取消
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.frame = CGRect(x: 8, y: 10, width: 60, height: 30)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor(hexString: "508fcd"), for: .normal)
//        cancelBtn.backgroundColor = UIColor(hexString: "FF7998")
        cancelBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        cancelBtn.cuttingCorner(radius: 8)
        topView.addSubview(cancelBtn)
        
        // 确定
        let sureBtn = UIButton(type: .custom)
        sureBtn.frame = CGRect(x: kScreen_w - 60 - 8, y: 10, width: 60, height: 30)
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor(hexString: "508fcd"), for: .normal)
//        sureBtn.backgroundColor = UIColor(hexString: "FF7998")
        sureBtn.addTarget(self, action: #selector(sure), for: .touchUpInside)
        sureBtn.cuttingCorner(radius: 8)
        topView.addSubview(sureBtn)
        
        pickView = UIPickerView(frame: CGRect(x: 0, y: 50, width: kScreen_w, height: contentHeight - 50.0))
        pickView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        pickView.delegate = self
        pickView.dataSource = self
        contentView.addSubview(pickView)
        
        selectIndex = dataArray.count/2 - 1
        pickView.selectRow(selectIndex, inComponent: 0, animated: true)

    }
    
    fileprivate func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.coverView.alpha = 0.4
            self.contentView.transform = CGAffineTransform(translationX: 0, y: -self.contentView.bounds.height)
        }, completion: nil)
    }
    
    @objc fileprivate func sure() {
        if selectCallBlock != nil {
            selectCallBlock!(dataArray[selectIndex])
        }
        close()
    }
    
    @objc fileprivate func close() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.coverView.alpha = 0.0
            self.contentView.transform = CGAffineTransform.identity
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
}

extension StringPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickView.subviews[1].backgroundColor = UIColor.clear
        pickView.subviews[2].backgroundColor = UIColor.clear
        return dataArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       //将在滑动停止后触发，并打印出选中列和行索引
        selectIndex = row
    }
}
