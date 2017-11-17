//
//  LCActionSheetController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/7.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class LCActionSheetController: UIViewController {

    // ----------------外界调用的属性值--------------
    var valueBlock: valueBlock?
    /// cell内容
    var cellTitleList = [String]()
    /// cell字体颜色
    var cellTitleColor = UIColor.green
    /// cell字体大小
    var cellTitleFont: CGFloat = 17
    /// 标题
    var titleString: String? = "我是一个标题"
    /// 标题字体大小
    var titleFont: CGFloat = 15
    
    
    // ---------------内部属性-------------------
    typealias valueBlock = (NSInteger)->Swift.Void
    
    fileprivate var tableView = UITableView()
    fileprivate var overVeiw = UIView()
    fileprivate let cellID = "cellID"
    
    fileprivate var tableViewHight: CGFloat {
        return CGFloat(cellTitleList.count) * rowHight + headerViewHight + footerViewHight
    }
    
    fileprivate let rowHight: CGFloat = 50
    fileprivate let headerViewHight: CGFloat = 50
    fileprivate var footerViewLineHight: CGFloat = 5
    
    fileprivate var footerViewHight: CGFloat {
        return headerViewHight + footerViewLineHight
    }
    
    required init?(cellTitleList: [String]!) {
        super.init(nibName: nil, bundle: nil)
        // 初始化
        self.cellTitleList = cellTitleList;
        
        view.backgroundColor = UIColor.clear
        // 模态半透明弹出框
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .custom
        
        // 初始化UI
        setupUIViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.25) {
            var frame = self.tableView.frame
            frame.origin.y = kScreen_h-self.tableViewHight
            self.tableView.frame = frame
            self.overVeiw.alpha = 0.4
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: 初始化UI
extension LCActionSheetController {
    func setupUIViews() {
        
        /// 遮罩层
        overVeiw = UIView(frame: CGRect(x: 0, y: 0, width:kScreen_w, height: kScreen_h))
        overVeiw.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        overVeiw.alpha = 0.0
        view.addSubview(overVeiw)
        
        /// tableview
        tableView = UITableView(frame: CGRect(x: 0, y: kScreen_h, width: kScreen_w, height: tableViewHight), style: .plain)
        overVeiw.addSubview(tableView)
        tableView.backgroundColor = UIColor.cyan
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.bounces = false
        tableView.isPagingEnabled = false
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.register(LCTitleCell.classForCoder(), forCellReuseIdentifier: cellID)
    }
}

// MARK: 点击屏幕弹出退出
extension LCActionSheetController {
    
    func sheetViewDismiss() {
        
        UIView.animate(withDuration: 0.25, animations: {
            var frame = self.tableView.frame
            frame.origin.y = kScreen_h
            self.tableView.frame = frame
            self.overVeiw.alpha = 0.4
            
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sheetViewDismiss()
    }
    
    @objc func cancelBtnDidClick(btn: UIButton) {
        sheetViewDismiss()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension LCActionSheetController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! LCTitleCell
        cell.titleLabel.text = cellTitleList[indexPath.row]
        cell.titleLabel.textColor = cellTitleColor
        cell.titleLabel.font = UIFont.systemFont(ofSize: cellTitleFont)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(rowHight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (self.valueBlock != nil) {
            self.valueBlock!(indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerViewHight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return headerViewHight + footerViewLineHight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreen_w, height: headerViewHight))
        view.backgroundColor = UIColor.white
        // 标题
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: kScreen_w, height: headerViewHight))
        titleLabel.text = titleString
        titleLabel.font = UIFont.systemFont(ofSize: titleFont)
        titleLabel.textColor = UIColor.lightGray
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        // 线
        let lineView = UIView(frame: CGRect(x: 0, y: view.frame.size.height-1, width: kScreen_w, height: 1))
        lineView.backgroundColor = UIColor(red: 220/250.0, green: 220/250.0, blue: 220/250.0, alpha: 1.0)
        view.addSubview(lineView)
        return view
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreen_w, height: footerViewHight))
        footerView.backgroundColor = UIColor.white
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: kScreen_w, height: footerViewLineHight))
        lineView.backgroundColor = UIColor.lightGray
        footerView.addSubview(lineView)
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: footerViewLineHight, width: kScreen_w, height: footerViewHight-footerViewLineHight)
        footerView.addSubview(btn)
        btn.setTitle("取消", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: titleFont)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(cancelBtnDidClick(btn:)), for: .touchUpInside)
        
        return footerView;
    }
}

