//
//  MineTableViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/10.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class MineTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
        /// 表示登录成功在请求数据
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: Notification.Name.Task.loginSuccess, object: nil)
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
    }
    
    @objc fileprivate func fetchData() {
        
        /// 表示必须要登录后才能请求数据
        if isLogin().0 {
            
            NetworkTools.fetchMineInfo(isLogin().1) { (homeModel) in
                
                printLog("信用额度---\(String(describing: homeModel.totalAmount))")
                printLog("用户数---\(String(describing: homeModel.totalPersonNumber))")
                
            }
        }
 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 4 {
            
            ShareView.show(frame: UIScreen.main.bounds, selectCallBack: { (index) in
                
                printLog("点击了第\(index)个")
                
            })
            
        }
        
    }

}
