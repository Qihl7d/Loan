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
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var personLab: UILabel!

    fileprivate var creditLab: LCCounterLabel!
    fileprivate var headImage: UIImageView! // 头像
    fileprivate var qipaoImage: UIImageView!  // 气泡
    
    fileprivate var gradientLayer:CAGradientLayer!  //渐变层
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(r: 39, g: 143, b: 166)
        UIApplication.shared.statusBarStyle = .lightContent
        creditLab.countFrom(start: 6123, to: 6543, duration: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        printLog("-----------home已经销毁--------------")
    }
    
    // MARK: - Action
    
    /// 消息中心
    @IBAction func centerInfoAction(_ sender: UIBarButtonItem) {
        
//        let loginNav = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginNavigationController") as! UINavigationController
//        _ = loginNav.viewControllers[0] as! LoginViewController
//        
//        self.present(loginNav, animated: true, completion: nil)
    }
    
    ///  立即借款
    @IBAction func lendAction(_ sender: UIButton) {
        
//        NetworkTools.fetchInfo { (_) in
//
//        }

        let repay = BorrowViewController()
        navigationController?.pushViewController(repay, animated: true)
    }
}

extension HomeViewController {
    
    fileprivate func setupUI() {
                
        JPUSHService.setAlias("18782967728", completion: { (resCode, tags, index) in
            
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
        
        let string = "已有13579人加入中融秒贷"
        let ranStr = "13579"
        let str = NSString(string: string)
        let range = str.range(of: ranStr)
        let attriStr = NSMutableAttributedString(string: string)
        attriStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(hexString: "FFC633"), range: range)
        personLab.attributedText = attriStr
        
        creditLab = LCCounterLabel(frame: CGRect.zero, type: .Int)
        cardImage.addSubview(creditLab)
        creditLab.textColor = UIColor.white
        creditLab.font = UIFont.boldSystemFont(ofSize: 30)
        
        creditLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(cardImage).offset(40)
            make.centerY.equalTo(cardImage)
            make.width.equalTo((kScreen_w - 60)/3)
        }
        
        // 背景渐变色
        let colors = [UIColor(r: 39, g: 143, b: 166).cgColor,
                      UIColor(r: 24, g: 124, b: 224).cgColor]
        //创建CAGradientLayer对象
        gradientLayer = CAGradientLayer()
        //设置初始渐变色
        gradientLayer.colors = colors
        //每种颜色所在的位置
        gradientLayer.locations = [0.1,1.0]
        
        //设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = self.view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
        
//        tableView = UITableView(frame: CGRect.zero, style: .plain)
//        tableView.backgroundColor = UIColor.clear
//        tableView.tableFooterView = UIView()
//        view.addSubview(tableView)
//
//        cardImg = UIImageView()
//        tableView.addSubview(cardImg)
//        cardImg.image = UIImage(named: "home_card")?.withRenderingMode(.automatic)
//
      
//
//        commitBtn = UIButton()
//        tableView.addSubview(commitBtn)
//        commitBtn.cuttingCorner(radius: 10)
//        commitBtn.backgroundColor = UIColor.white
//        commitBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        commitBtn.setTitle("立即借款", for: .normal)
//        commitBtn.setTitleColor(UIColor(hexString: "#508fcd"), for: .normal)
//        commitBtn.addTarget(self, action: #selector(commitAction), for: .touchUpInside)
//
//        tableView.snp.makeConstraints { (make) in
//            make.top.left.bottom.right.equalTo(self.view)
//        }
//
//        if IS_IPhone_X {
//            cardImg.snp.makeConstraints { (make) in
//                make.height.equalTo(kScreen_h*0.25)
//                make.centerX.equalTo(self.view)
//                make.top.equalTo(40)
//                make.left.equalTo(self.view).offset(30)
//                make.right.equalTo(self.view).offset(-30)
//            }
//
//            commitBtn.snp.makeConstraints { (make) in
//                make.height.equalTo(40)
//                make.centerX.equalTo(self.view)
//                make.top.equalTo(kScreen_h - 300)
//                make.left.equalTo(self.view).offset(35)
//                make.right.equalTo(self.view).offset(-35)
//            }
//
//        }else {
//
//            cardImg.snp.makeConstraints { (make) in
//                make.height.equalTo(kScreen_h*0.3)
//                make.centerX.equalTo(self.view)
//                make.top.equalTo(40)
//                make.left.equalTo(self.view).offset(30)
//                make.right.equalTo(self.view).offset(-30)
//            }
//
//            commitBtn.snp.makeConstraints { (make) in
//                make.height.equalTo(40)
//                make.centerX.equalTo(self.view)
//                make.top.equalTo(kScreen_h - 260)
//                make.left.equalTo(self.view).offset(35)
//                make.right.equalTo(self.view).offset(-35)
//            }
//        }
    }
    
    fileprivate func fetchData() {
        
        let tel = "18782967728"
        
        NetworkTools.fetchMineInfo(tel) { (homeModel) in
            
            printLog("信用额度---\(String(describing: homeModel.totalAmount))")
            printLog("用户数---\(String(describing: homeModel.totalPersonNumber))")
            
        }
    }
    
   
}
