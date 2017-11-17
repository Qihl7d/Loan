//
//  BorrowViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/8.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class BorrowViewController: UIViewController {

    fileprivate var collectionView : UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#508fcd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - 懒加载
    fileprivate lazy var borrowView: LendView = {
        let  borrow = LendView.loadLendViewWithXib()
        borrow.frame = CGRect(x: 0, y: kScreen_h * 0.25, width: kScreen_w, height: kScreen_h * 0.75 - 88)
        borrow.delegate = self
        return borrow
    }()

}

extension BorrowViewController {
    
    fileprivate func setupUI() {
        
        title = "选择金额"
        view.backgroundColor = UIColor.white
        
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: kScreen_w, height: kScreen_h * 0.25))
        bgView.backgroundColor = UIColor(hexString: "#508fcd")
        view.addSubview(bgView)
        
        let layout = UICollectionViewFlowLayout() // LCCardFlowLayout 
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0) // kScreen_w/5
        layout.itemSize = CGSize(width: 150, height: 100)
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.frame = CGRect(x: 0, y: 0, width: kScreen_w, height: kScreen_h * 0.25)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentOffset = CGPoint(x: 0, y: 0) //CGPoint(x: kScreen_w/2 - 75, y: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        collectionView.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
        bgView.addSubview(collectionView)
        
        view.addSubview(borrowView)
    }
    
}

extension BorrowViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        if indexPath.row == 0 {
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cells = collectionView.visibleCells
        for item in cells {
            item.backgroundColor = UIColor.clear
        }

        let cell = collectionView.cellForItem(at: indexPath) as! CardCell
        cell.backgroundColor = UIColor.white
        
//        if indexPath.row == 0 || indexPath.row == 1 {
//            collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
//        }else{
//            collectionView.setContentOffset(CGPoint(x: 115, y: 0), animated: true)
//        }
        
        printLog("点击了第--\(indexPath.row)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        printLog("偏移量----\(scrollView.contentOffset.x)")
    }
    
}

extension BorrowViewController: LendViewDelegate {
    
    func btnActionWith(_ lendView: LendView, index: Int) {

        switch index {
        case 0:
            
            let buttons = [
                ["title": "7天","handler": "7天"],
                ["title": "14天","handler": "14天"],
                ["title": "21天","handler": "21天"]
            ]
            
            let cancelBtn = ["title": "取消",]
            
            let mmActionSheet = MMActionSheet.init(title: "请选择借款期限", buttons: buttons, duration: nil, cancelBtn: cancelBtn)
            mmActionSheet.callBack = { (handler) ->() in
                printLog("旋转的是----\(handler)")
                
                if handler == "7天" {
                    lendView.dayLab.text = "7天"
                }else if handler == "14天" {
                    lendView.dayLab.text = "14天"
                }else {
                    lendView.dayLab.text = "21天"
                }                
                
            }
            mmActionSheet.present()
            
        case 1:
            printLog("点击了-----\(index)")
        case 2:
            
            let bankVC = BankSelectViewController()
            navigationController?.pushViewController(bankVC, animated: true)
            
        case 3:
            printLog("点击了-----\(index)")
        default:
            break
        }
        
    }
}
