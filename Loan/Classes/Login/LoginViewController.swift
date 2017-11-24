//
//  LoginViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/10.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var codeBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.view.endEditing(false)
    }

    // MARK: - Action
    
    @IBAction func leftBarAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// 获取验证吗
    @IBAction func fetchCodeAction(_ sender: UIButton) {
        
        guard phoneTF.text != "" else {
            printLog("请输入手机号")
            MBProgressHUD.showMessage("请输入手机号~", toView: self.view)
            return
        }
        
        guard phoneTF.text!.characters.count == 11 else {
            printLog("请输入11位正确手机号~")
            MBProgressHUD.showMessage("请输入正确手机号~", toView: self.view)
            return
        }
        
        guard Validate.phoneNum(phoneTF.text!).isRight else {
            printLog("请输入11位正确手机号~")
            MBProgressHUD.showMessage("请输入11位正确手机号~", toView: self.view)
            return
        }
        
        //获取验证吗
        NetworkTools.fetchVerificationCode(phoneTF.text!) { (code) in
            printLog("验证吗----\(code)")
            
            DispatchQueue.main.async {
                self.codeTF.text = code
            }
        }
        
        codeBtn.isEnabled = false
        codeBtn.backgroundColor = UIColor.groupTableViewBackground

        // 定义需要计时的时间
        var timeCount = 10
        // 在global线程里创建一个时间源
        let codeTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
        // 设定时间源的触发事件
        codeTimer.setEventHandler(handler: {
            // 时间到了取消时间源
            if timeCount <= 1 {
                codeTimer.cancel()
                // codeTimer.suspend() // 暂停
                // 返回主线程处理一些事件，更新UI等等
                DispatchQueue.main.async {
                    self.codeBtn.setTitle("获取验证吗", for: .normal)
                    self.codeBtn.isEnabled = true
                    self.codeBtn.backgroundColor = UIColor(hexString: "5A8AC6")
                }
            }else {

                // 返回主线程处理一些事件，更新UI等等
                DispatchQueue.main.async {
                    self.codeBtn.setTitle("剩余\(timeCount)s", for: .normal)
                    self.codeBtn.isEnabled = false
                    self.codeBtn.backgroundColor = UIColor(hexColor: "5A8AC6", alpha: 0.8)
                }

                // 每秒计时一次
                timeCount = timeCount - 1
            }

        })
        // 启动时间源
        codeTimer.resume()
    }
    
    /// 登录
    @IBAction func loginAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        guard phoneTF.text != "" else {
            printLog("请输入手机号")
            MBProgressHUD.showMessage("请输入手机号~", toView: self.view)
            return
        }
        
        guard phoneTF.text!.characters.count == 11 else {
            printLog("请输入11位正确手机号~")
            MBProgressHUD.showMessage("请输入正确手机号~", toView: self.view)
            return
        }
        
        guard Validate.phoneNum(phoneTF.text!).isRight else {
            printLog("请输入11位正确手机号~")
            MBProgressHUD.showMessage("请输入11位正确手机号~", toView: self.view)
            return
        }
        
        guard codeTF.text != "" else {
            printLog("请输入验证码")
            MBProgressHUD.showMessage("请输入验证码~", toView: self.view)
            return
        }
        
        let tel = "\(phoneTF.text!)/\(codeTF.text!)"
        
        /// 提示：
        NetworkTools.loginAccount(tel) { (flag, msg) in
            
            printLog("登录返回消息----\(msg)")
            
            if flag {
                
                // 登录成功就保存用户id 和 手机号码， 当在程序被杀死的时候清除，以保证每次 用户来使用的时候先登录在使用
                
                UserDefaults.standard.set(msg, forKey: customId)
                UserDefaults.standard.set(self.phoneTF.text!, forKey: logigSuccess)
                UserDefaults.standard.synchronize()
                
                /// 发通知请求数据
                NotificationCenter.default.post(name: Notification.Name.Task.loginSuccess,
                                                object: nil,
                                                userInfo: nil)
                DispatchQueue.main.async {
                    MBProgressHUD.showMessage("登录成功", toView: self.view)
                    self.dismiss(animated: true, completion: nil)
                }
                
            }else {
                    
                DispatchQueue.main.async {
                    MBProgressHUD.showMessage(msg, toView: self.view)
                }
            }
            
//            else {
//              // 标志没有注册，我们先直接给他注册，然后在直接登录
//                NetworkTools.registerAccount(tel, complete: { (flag, msg) in
//
//                    // 表示注册成功，直接登录
//                    if flag {
//
//                        NetworkTools.loginAccount(tel, complete: { (flag, msg) in
//
//                            if flag {
//
//                                DispatchQueue.main.async {
//                                    MBProgressHUD.showMessage("登录成功", toView: keyView)
//                                    //                self.dismiss(animated: true, completion: nil)
//                                }
//                            }
//
//                        })
//
//                    }else {
//                        DispatchQueue.main.async {
//                            MBProgressHUD.showMessage("登录失败，请稍后再试~", toView: keyView)
//                        }
//                    }
//
//                })
//
//            }
            
        }

    }
    
}

extension LoginViewController {
    
    fileprivate func setupUI() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#508fcd")
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        phoneTF.delegate = self
        codeTF.delegate = self
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if phoneTF == textField {
            guard let text = textField.text else {
                return true
            }
            
            let textLength = text.characters.count + string.characters.count - range.length
            
            return textLength <= 11
        }
        
        if codeTF == textField {
            guard let text = textField.text else {
                return true
            }
            
            let textLength = text.characters.count + string.characters.count - range.length
            
            return textLength <= 6
        }
    
        return false
    }
}
