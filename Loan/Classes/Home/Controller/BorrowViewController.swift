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
    
    fileprivate var dataArray: [String] = ["¥500","¥1000","¥1500","¥2000"]
    
    // 默认第二个被选中
    fileprivate var selectIndex: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#508fcd")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        selectIndex = 1
//        collectionView.reloadData()
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
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        
        cell.moneyLab.text = dataArray[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        if indexPath.row == selectIndex {
            UIView.animate(withDuration: 0.25, animations: {
                cell.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
//                cell.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1)
            })
            
        }else {
            UIView.animate(withDuration: 0.25, animations: {
//                cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1)
                cell.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            })
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            collectionView.setContentOffset(CGPoint(x: -15, y: 0), animated: true)
        }else if indexPath.row == 1{
            collectionView.setContentOffset(CGPoint(x: 32, y: 0), animated: true)
        }else if indexPath.row == 2 {
            collectionView.setContentOffset(CGPoint(x: 185, y: 0), animated: true)
        }else {
            collectionView.setContentOffset(CGPoint(x: 200, y: 0), animated: true)
        }
        
        guard selectIndex != indexPath.row else {
            return
        }
        
        selectIndex = indexPath.row
        collectionView.reloadData()
        
//        let cells = collectionView.visibleCells
//        for item in cells {
//            item.backgroundColor = UIColor.clear
//            item.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
//        }
//
//        let cell = collectionView.cellForItem(at: indexPath) as! CardCell
//        cell.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        
      
        
        printLog("点击了第--\(indexPath.row)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        printLog("偏移量\(scrollView.contentOffset.x)")
    }
    
}

extension BorrowViewController: LendViewDelegate {
    
    func btnActionWith(_ lendView: LendView, index: Int) {

        switch index {
        case 0:
            
            let dataStr = ["7天","14天","21天","28天"]
            
//            StringPickerView.show(dataArray: dataStr) { (text) in
//                printLog("选择了----\(text)")
//                lendView.dayLab.text = text
//            }
            
            StringPickerView.show("请选择借款期限", dataArray: dataStr, selectBlock: { (text) in
                printLog("选择了----\(text)")
                lendView.dayLab.text = text
            })
            
//            let buttons = [
//                ["title": "7天","handler": "7天"],
//                ["title": "14天","handler": "14天"],
//                ["title": "21天","handler": "21天"]
//            ]
//
//            let cancelBtn = ["title": "取消",]
//
//            let mmActionSheet = MMActionSheet.init(title: "请选择借款期限", buttons: buttons, duration: nil, cancelBtn: cancelBtn)
//            mmActionSheet.callBack = { (handler) ->() in
//                printLog("旋转的是----\(handler)")
//
//                if handler == "7天" {
//                    lendView.dayLab.text = "7天"
//                }else if handler == "14天" {
//                    lendView.dayLab.text = "14天"
//                }else {
//                    lendView.dayLab.text = "21天"
//                }
//
//            }
//            mmActionSheet.present()
            
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
