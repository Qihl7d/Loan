//
//  LCNavigationController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/7.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class LCNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    var currentVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            let back = UIButton(type: .custom)
            back.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            back.setImage(UIImage(named: "leftbackIcon"), for: .normal)
            back.adjustsImageWhenHighlighted = false
            
            //让按钮内部的所有内容左对齐
//            back.sizeToFit()
            back.contentHorizontalAlignment = .left
            back.addTarget(self, action: #selector(backOfViewController), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: back)
            
            super.pushViewController(viewController, animated: animated)
            
            // 修改tabBra的frame
            if IS_IPhone_X {
                var frame = self.tabBarController?.tabBar.frame
                frame!.origin.y = kScreen_h - frame!.size.height
                self.tabBarController?.tabBar.frame = frame!
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        if navigationController.viewControllers.count == 1 {
            self.currentVC = nil
        }else{
            self.currentVC = viewController
        }
        
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            return self.currentVC == self.topViewController
        }
        
        return true
    }
    
    @objc func backOfViewController() {
        self.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
