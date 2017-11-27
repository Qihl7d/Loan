//
//  MineTableViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/10.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class MineTableViewController: UITableViewController {

    @IBOutlet weak var motionV: UIView!
    /// 头像
    @IBOutlet weak var headImg: UIImageView!
    /// 用户名
    @IBOutlet weak var nameLab: UILabel!
    /// 可用额度
    @IBOutlet weak var amountLab: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
        /// 表示登录成功在请求数据
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: Notification.Name.Task.loginSuccess, object: nil)
        
        /// 显示登录按钮
        NotificationCenter.default.addObserver(self, selector: #selector(showLogin), name: Notification.Name.Task.showLogin, object: nil)

    }
    
    @objc fileprivate func showLogin() {
        bgView.isHidden = false
        
        printLog("登录按钮已经显示-----0.0")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // 统一返回的unwind segue
    @IBAction func closeVc(segue: UIStoryboardSegue) {
        printLog("关闭视图控制器")
        
        printLog("--------------")
        printLog(segue.destination)
        printLog(segue.identifier)
        printLog(segue.source)
        printLog("--------------")
        
        if segue.destination == self && segue.source == BankViewController()  {
            let bankVc = segue.source as! BankViewController
            printLog("银行卡----\(bankVc.bankNameArray)")
        }
        
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        persentLogin(self)
    }
    

    fileprivate func setupUI() {
        
        // 默认情况下extendedLayoutIncludesOpaqueBars = false 扩展布局不包含导航栏
        extendedLayoutIncludesOpaqueBars = true
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        
        // 登录按钮
        loginBtn.cuttingCorner(radius: 19)
        loginBtn.setupBorder(width: 2, color: UIColor.white)
        
        
        // 加入我的贴纸标签
        
        let motionRect = CGRect(x: 0, y: 0, width: kScreen_w, height: 200)
        let imgArr: [String] = ["图片1","图片2","图片3","图片4","图片5","图片6","图片7","图片8","图片9","图片10","图片11"]
        let motionView = MotionView(frame: motionRect, imageArr: imgArr)
        motionView.backgroundColor = UIColor.clear
        self.motionV.addSubview(motionView)

    }
    
    @objc fileprivate func fetchData() {
        
        /// 表示必须要登录后才能请求数据
        if isLogin().0 {
            
            bgView.isHidden = true
            
            NetworkTools.fetchMineInfo(isLogin().phone) { (homeModel) in
                printLog("信用额度---\(String(describing: homeModel.totalAmount))")
                printLog("用户数---\(String(describing: homeModel.totalPersonNumber))")
                
                DispatchQueue.main.async {
                    self.headImg.image = UIImage(named: "mine_head")
                    self.nameLab.text = isLogin().phone
                    self.amountLab.text = "可用额度：¥10000"
                }
            }
            
        }else {
            bgView.isHidden = false
            
            // 未登录就现实 请先登录
            headImg.image = UIImage(named: "mine_head")
            nameLab.text = "请先登录"
            amountLab.text = "可用额度：¥10000"
        }
 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        /// 一下功能需要先登录
        guard isLogin().0 else {
            // 先去登录
            persentLogin(self)
            return
        }
        
        /// 借款记录
        if indexPath.row == 1 {
            performSegue(withIdentifier: "LoanRecordIdentifier", sender: nil)
        }
        
        /// 银行卡管理
        if indexPath.row == 2 {
            performSegue(withIdentifier: "BankManagerIdentifier", sender: nil)
        }
        
        /// 帮助中心
        if indexPath.row == 3 {
            performSegue(withIdentifier: "HelpCenterIdentifier", sender: nil)
        }
        
        /// 分享app
        if indexPath.row == 4 {
            ShareView.show(frame: UIScreen.main.bounds, selectCallBack: { (index) in
                printLog("点击了第\(index)个")
            })
        }
        
        /// 设置
        if indexPath.row == 5 {
            performSegue(withIdentifier: "SettingIdentifier", sender: nil)
        }
        
    }

}
