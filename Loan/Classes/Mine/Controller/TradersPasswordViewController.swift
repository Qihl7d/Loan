//
//  TradersPasswordViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/16.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit
import MBProgressHUD

/// 设置交易密码
class TradersPasswordViewController: UIViewController {

    @IBOutlet weak var customViewHeight: NSLayoutConstraint!
    
    var passworldTF: UITextField!
    var pointViewArr: [UIView] = []
    var psd: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        if IS_IPhone_X {
           customViewHeight.constant = 88
        }
        
        showView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passworldTF.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Action
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension TradersPasswordViewController: UITextFieldDelegate {
    
    fileprivate func showView() {
        
        let tipLabel = UILabel.init(frame: CGRect.init(x: 20, y: 150, width: kScreen_w-40, height: 40))
        tipLabel.text = "请输入6位交易密码"
        tipLabel.textColor = UIColor(hexString: "424242")
        tipLabel.textAlignment = NSTextAlignment.center
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(tipLabel)
        
        passworldTF = UITextField.init(frame: CGRect.init(x: 20, y: 200, width: kScreen_w-40, height: 40))
        if (kScreen_w > 320) {
            passworldTF.frame = CGRect.init(x: 30, y: 200, width: kScreen_w-60, height: 50)
        }
        
        passworldTF.backgroundColor = UIColor.white
        passworldTF.layer.borderWidth = 1
        passworldTF.layer.borderColor = UIColor(hexString: "e0e0e0").cgColor
        passworldTF.keyboardType = UIKeyboardType.numberPad
        passworldTF.tintColor = UIColor.clear
        passworldTF.textColor = UIColor.clear
        passworldTF.delegate = self
        passworldTF.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: passworldTF.width, height: passworldTF.height))
        passworldTF.leftViewMode = UITextFieldViewMode.always
        view.addSubview(passworldTF)
        
        let lineSpaceWidth = passworldTF.width / 6
        
        //5条竖线
        var i = 1
        for _ in 1...5 {
            let xLine = CGFloat(i)*lineSpaceWidth
            let lineView = UIView.init(frame: CGRect.init(x: xLine, y: 0, width: 0.5, height: passworldTF.height))
            lineView.backgroundColor = UIColor(hexString: "e0e0e0")
            passworldTF.addSubview(lineView)
            i = i + 1
        }
 
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        printLog("输入的-?\(string)?-\(range)")
        
        if (textField == self.passworldTF) {
            
            if (range.location >= 6) {
                // 密码等于6位 就禁止输入了
                return false
                
            } else {
                
                if string == "" {
                    // 表示用户在点击删除
                    if psd.count != 0 {
                        //文本删除状态
                        //移除黑点
                        pointViewArr[range.location].removeFromSuperview()
                        pointViewArr.remove(at: range.location)
                        
                        self.psd.removeLast()
                    }
                    
                } else {
                    // 表示用户正在输入密码
                    if (range.length == 0) {
                        
                        //文本输入状态
                        let pointX = ((passworldTF.width-62.5) / 12) * CGFloat(range.location * 2 + 1) + CGFloat(range.location) * 10.5
                        let pointY = (passworldTF.height-10) / 2
                        
                        //显示黑点
                        let blackPoint = UIView.init(frame: CGRect.init(x: pointX, y: pointY, width: 12.0, height: 12.0))
                        blackPoint.layer.cornerRadius = 6
                        blackPoint.backgroundColor = UIColor.black
                        
                        passworldTF.addSubview(blackPoint)
                        pointViewArr.append(blackPoint)
                        
                    }
                    
                    self.psd.append(string)
                }

                printLog(psd)
    
                if psd.count == 6 {
                    
                    // 拼接密码字符串
                    _ = psd.joined(separator: "")
                    
                    
                    DispatchQueue.main.async {
                        MBProgressHUD.showMessage("交易密码设置成功", toView: keyView)
                        self.navigationController?.popViewController(animated: true)
                    }
  
                }
                
                return true
            }
        }
        return true
    }
    
}


