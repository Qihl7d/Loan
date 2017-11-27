//
//  BankViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/14.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

/// 银行卡管理中心
class BankViewController: UIViewController {

    @IBOutlet weak var customViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    ///开始滑动时的 Y 值
    fileprivate var startY: CGFloat!
    ///向上滑动
    fileprivate var upSliding: Bool!
    ///第一次运行
    fileprivate var isFirstRun: Bool!
    
    var bankNameArray: [String] = {
        return ["中国银行","建设银行","农业银行","招商银行","交通银行","中国银行","建设银行","农业银行","招商银行","交通银行"]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setupUI()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action    
    @IBAction func addBackAction(_ sender: UIButton) {

    }
 
}

extension BankViewController {
    
    fileprivate func setupUI() {
        
        if IS_IPhone_X {
            customViewConstraint.constant = 88
        }
        
        view.backgroundColor = UIColor(r: 38, g: 44, b: 50, alpha: 1)
        
        startY = 0.0
        isFirstRun = true
        upSliding = true
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreen_w - 20, height: 130)
        layout.minimumLineSpacing = -20
        collectionView.backgroundColor = UIColor(r: 38, g: 44, b: 50, alpha: 1)
        collectionView.collectionViewLayout = layout
        collectionView.alwaysBounceVertical = true
        
        NetworkTools.fetchCard(2) { (bankArray) in
 
        }

    }
}

extension BankViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bankNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bankManagerCell", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        printLog("点击了第\(indexPath.row)个")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if isFirstRun {
            /*第一次运行显示界面时 所有显示的cell都放到最高层 后出现的就会压住前面的*/
            //上
            collectionView.bringSubview(toFront: cell)
        }else {
            if upSliding {
                /* 向上滑时 后出现的就会压住前面的*/
                //上滑
                collectionView.bringSubview(toFront: cell)
            }else {
                /* 向下滑时 把每个将要出现的放到最底部 后出现的就会在前一个cell的下面*/
                //下滑
                collectionView.sendSubview(toBack: cell)
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startY = scrollView.contentOffset.y
        isFirstRun = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < startY {
            //下
            upSliding = false
        }else {
            //上
            upSliding = true
        }
        startY = scrollView.contentOffset.y
    }
    
}
