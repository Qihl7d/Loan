//
//  MsgCenterViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/16.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit

class MsgCenterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellTitles = ["信用额度是中融秒贷根据您提交的资料情况及您的借贷情况授予您的最大借款额度，您获取信用额度后才能操作借款。可借金额以获取到的信用额度为准",
                      "用户注册之后现金贷额度默认1000元，需要通过所有认证才能激活现金贷并申请借款。具体可借额度有您提供的信息，再审核之后确定",
                      "借款期限有7天、14天、21天",
                      "借款手续费会在借款时扣除。比如您申请了一笔1000元的借款，手续费为150元，实际到账为1000元，再立即扣除150手续费(具体费用按当时借款实际显示费用为准)",
                      "个人信息认证，收款银行卡绑定，授权芝麻信用，运营商授权",
                      "当然不可以啦～",
                      "当天提交的审核保证当天处理，下午18点后提交的审核需要延迟到第二天工作时间处理，审核速度和当天的单量挂钩",
                      "审核通过后2小时以内打款"]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#508fcd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.estimatedRowHeight = 50 //预设cell高度
        tableView.rowHeight = UITableViewAutomaticDimension
        
        view.addSubview(noMsgView)
        
        noMsgView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(self.view)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate lazy var noMsgView: NoMesView = {
       let noview = NoMesView.noMsgView()
        return noview
    }()

}

extension MsgCenterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MsgCenterCell", for: indexPath) as! MsgCell
        cell.msgLab.text = cellTitles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
