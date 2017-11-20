//
//  HomeViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/7.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var cardImgConstraint: NSLayoutConstraint!
    @IBOutlet weak var personImgConstraint: NSLayoutConstraint!
    @IBOutlet weak var loanBtnConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var personLab: UILabel!

    fileprivate var creditLab: LCCounterLabel!
    fileprivate var headImage: UIImageView! // 头像
    fileprivate var qipaoImage: UIImageView!  // 气泡
    
    fileprivate var gradientLayer:CAGradientLayer!  //渐变层
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(r: 82, g: 158, b: 178)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
        
        if !isLogin().0 {
            
            let string = "已有1250人加入中融秒贷"
            let ranStr = "1250"
            let str = NSString(string: string)
            let range = str.range(of: ranStr)
            let attriStr = NSMutableAttributedString(string: string)
            attriStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(hexString: "FFC633"), range: range)
            self.personLab.attributedText = attriStr
            creditLab.countFrom(start: 8888, to: 10000, duration: 1)
        }

        /// 表示登录成功在请求数据
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: Notification.Name.Task.loginSuccess, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if IS_IPhone6_6s_7_8 {
            loanBtnConstraint.constant = 100
        }
        
        if IS_IPhone6p_6sp_7p_8p {
            cardImgConstraint.constant = 185 + 50
            personImgConstraint.constant = 60
            loanBtnConstraint.constant = 100
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    // MARK: - Action
    
    ///  立即借款
    @IBAction func lendAction(_ sender: UIButton) {
        
        // 判断如果没有登录
        if isLogin().0 {
            let repay = BorrowViewController()
            navigationController?.pushViewController(repay, animated: true)
        }else {
            let loginNav = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginNavigationController") as! UINavigationController
            _ = loginNav.viewControllers[0] as! LoginViewController
            
            self.present(loginNav, animated: true, completion: nil)
        }
    }
}

extension HomeViewController {
    
    fileprivate func setupUI() {
        
        /// 推送设置别名 制定这个手机号才能推送
        
        let tel = "18782967728"
        
        JPUSHService.setAlias(tel, completion: { (resCode, tags, index) in
            
            /*
             温馨提示，设置标签别名请注意处理call back结果。
             只有call back 返回值为 0 才设置成功，才可以向目标推送。否则服务器 API 会返回1011错误。所有回调函数都在主线程运行。
             */
            printLog("---\(resCode)-\(String(describing: tags))-\(index)")
            
        }, seq: 0)

        //        // 默认情况下extendedLayoutIncludesOpaqueBars = false 扩展布局不包含导航栏
        //        extendedLayoutIncludesOpaqueBars = true
        //        if #available(iOS 11.0, *) {
        ////            tableView.contentInsetAdjustmentBehavior = .never
        //        }else {
        //            automaticallyAdjustsScrollViewInsets = false
        //        }
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()

        creditLab = LCCounterLabel(frame: CGRect.zero, type: .Int)
        cardImage.addSubview(creditLab)
        creditLab.textColor = UIColor.white
        creditLab.font = UIFont.boldSystemFont(ofSize: 30)
        
        creditLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(cardImage).offset(40)

            if IS_IPhone5_5s || IS_IPhone6_6s_7_8 || IS_IPhone_X {
               make.centerY.equalTo(cardImage).offset(-8)
            }
            
            if IS_IPhone6p_6sp_7p_8p {
                make.centerY.equalTo(cardImage).offset(-10) // 6sp
            }
            
            make.width.equalTo((kScreen_w - 60)/3)
        }
        
        printLog("卡片的frame---\(cardImage.bounds)")
        
        // 背景渐变色
        let colors = [UIColor(r: 82, g: 158, b: 178).cgColor,
                      UIColor(r: 64, g: 131, b: 217).cgColor,
                      UIColor(r: 49, g: 110, b: 180).cgColor]
        //创建CAGradientLayer对象
        gradientLayer = CAGradientLayer()
        //设置初始渐变色
        gradientLayer.colors = colors
        //每种颜色所在的位置
        gradientLayer.locations = [0.1,0.5,1.0]

        //设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = self.view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)

    }
    
    @objc fileprivate func fetchData() {
        
        if isLogin().0 {
            
            NetworkTools.fetchMineInfo(isLogin().1) { (homeModel) in
                
                printLog("信用额度---\(String(describing: homeModel.totalAmount))")
                printLog("用户数---\(String(describing: homeModel.totalPersonNumber))")
                
                DispatchQueue.main.async {
                    
                    var per = ""
                    
                    if let person = homeModel.totalPersonNumber {
                        per = "\(12500 + person)"
                    }else{
                        per = "12500"
                    }
                    
                    let string = "已有\(per)人加入中融秒贷"
                    let ranStr = per
                    let str = NSString(string: string)
                    let range = str.range(of: ranStr)
                    let attriStr = NSMutableAttributedString(string: string)
                    attriStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(hexString: "FFC633"), range: range)
                    self.personLab.attributedText = attriStr
                    
                    if homeModel.totalAmount != nil {
                        self.creditLab.countFrom(start: 6123 + homeModel.totalAmount!, to: 6543 + homeModel.totalAmount!, duration: 1)
                    }else{
                        self.creditLab.countFrom(start: 2500, to: 3000, duration: 1)
                    }
                    
                }
            }
        }
        
    }
    
   
}
