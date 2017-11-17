//
//  ShareView.swift
//  Loan
//
//  Created by lau Andy on 2017/11/16.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class ShareView: UIView {

    fileprivate var coverView: UIView!
    fileprivate var contentView: UIView!
    
    fileprivate var selectCallBack: ((_ index: Int) -> Swift.Void)?
    fileprivate var cancelCallBack: (() -> Swift.Void)?

    fileprivate lazy var collection: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = CGRect(x: 0, y: 0, width: kScreen_w, height: 200)
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = UIColor.groupTableViewBackground //UIColor(hexString: "f3f3f6")
        
        // 注册cell
        collectionView.register(UINib(nibName: "ShareCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ShareCell")
        
        return collectionView
        }()
    
    init(frame: CGRect, selectCallBlak:((_ index: Int) -> Swift.Void)?) {
        super.init(frame: frame)
        self.selectCallBack = selectCallBlak
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    class func show(frame: CGRect, selectCallBack: ((_ index: Int) -> Swift.Void)?) {
        ShareView(frame: frame, selectCallBlak: selectCallBack).show()
    }
    
    func setupUI() {
        
        // 设置背景
        coverView = UIView(frame: self.bounds)
        coverView.backgroundColor = UIColor.black
        coverView.alpha = 0.0
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        coverView.addGestureRecognizer(tap)
        addSubview(coverView)
        
        // 内容
        contentView = UIView(frame: CGRect(x: 0, y: frame.height, width: frame.width, height: 250))
        contentView.backgroundColor = UIColor.groupTableViewBackground
        addSubview(contentView)
        
        // 添加collection
        contentView.addSubview(collection)

        let cancelButton = UIButton(frame: CGRect(x: 0, y: 200, width: frame.width, height: 50))
        cancelButton.setTitle( "取消" , for: .normal)
        cancelButton.setTitleColor(UIColor(hexString: "6e6e6e"), for: .normal)
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        cancelButton.backgroundColor = UIColor(hexString: "ffffff")
        cancelButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        contentView.addSubview(cancelButton)
        
        // 设置阴影
        cancelButton.layer.shadowColor = UIColor.black.cgColor
        cancelButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        cancelButton.layer.shadowRadius = 5.0
        cancelButton.layer.shadowOpacity = 0.3
        
        
    }
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.coverView.alpha = 0.4
            self.contentView.transform = CGAffineTransform(translationX: 0, y: -self.contentView.bounds.height)
        }, completion: nil)
    }
    
    @objc func close() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.coverView.alpha = 0.0
            self.contentView.transform = CGAffineTransform.identity
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    
    
}

extension ShareView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareCell", for: indexPath) as! ShareCell
        
        let imageArr = ["mine_wechat","mine_qq","mine_friends","mine_qqZ"]
        let titleArr = ["微信好友","QQ","朋友圈","qq空间"]
        
        cell.shareImg.image = UIImage(named: imageArr[indexPath.row])
        cell.shareTitle.text = titleArr[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了第\(indexPath.section)组的第\(indexPath.row)")
        
        if selectCallBack != nil {
            selectCallBack!(indexPath.row)
        }
        close()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ShareView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreen_w/3, height: 100)
    }
    
}
