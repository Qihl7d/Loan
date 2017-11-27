//
//  HelpViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/11.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit
import Meiqia

/// 帮助中心
class HelpViewController: UIViewController {

    @IBOutlet weak var customViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedCellIndexPath:IndexPath!
    
    let sentionTitles = ["1.信用额度是什么？","2.可借额度是什么？","3.可借期限是什么？","4.借款手续费？","5.借款申请需要做哪些认证？","6.我可以用多个手机来借款吗？","7.手机审核需要多久？","8.审核后多久放款？"]
    
    let cellTitles = ["信用额度是中融秒贷根据您提交的资料情况及您的借贷情况授予您的最大借款额度，您获取信用额度后才能操作借款。可借金额以获取到的信用额度为准",
                      "用户注册之后现金贷额度默认1000元，需要通过所有认证才能激活现金贷并申请借款。具体可借额度有您提供的信息，再审核之后确定",
                      "借款期限有7天、14天、21天",
                      "借款手续费会在借款时扣除。比如您申请了一笔1000元的借款，手续费为150元，实际到账为1000元，再立即扣除150手续费(具体费用按当时借款实际显示费用为准)",
                      "个人信息认证，收款银行卡绑定，授权芝麻信用，运营商授权",
                      "当然不可以啦～",
                      "当天提交的审核保证当天处理，下午18点后提交的审核需要延迟到第二天工作时间处理，审核速度和当天的单量挂钩",
                      "审核通过后2小时以内打款"]

    let flagArray : NSMutableArray = NSMutableArray()
    
    let cellArray : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if IS_IPhone_X {
            customViewHeight.constant = 88
        }
        
        // 默认情况下extendedLayoutIncludesOpaqueBars = false 扩展布局不包含导航栏
        extendedLayoutIncludesOpaqueBars = true
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        for _ in 0...sentionTitles.count - 1 {
            flagArray.add(false)
        }
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.estimatedRowHeight = 200 //预设cell高度
        tableView.rowHeight = UITableViewAutomaticDimension
        UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action

    /// 联系客服
    @IBAction func chatAction(_ sender: UIButton) {
        let chatVC = MQChatViewManager()
        chatVC.enableSyncServerMessage(true) // 同步服务器消息
        chatVC.setNavTitleText("中融客服")
        chatVC.setChatWelcomeText("欢迎使用中融借款客服服务～")
        chatVC.pushMQChatViewController(in: self)
    }
    
}

extension HelpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sentionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flagArray[section] as! Bool{
            return 1
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "cell\(indexPath.section)\(indexPath.row)"
        self.tableView.register(UINib.init(nibName: "HelpTableCell", bundle: Bundle.main), forCellReuseIdentifier: identifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HelpTableCell
        
        let content : String = cellTitles[indexPath.section]
        
        let attributesString = NSMutableAttributedString.init(string : content)
        //创建NSMutableParagraphStyle
        let paraghStyle = NSMutableParagraphStyle()
        //设置行间距（同样这里可以设置行号，间距，对齐方式）
        paraghStyle.lineSpacing = cell.cellTitle.font.lineHeight
        //添加属性，设置行间距
        attributesString.addAttributes([NSAttributedStringKey.paragraphStyle : paraghStyle], range: NSMakeRange(0, content.characters.count))
        
        cell.cellTitle.text = cellTitles[indexPath.section] //attributesString
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = Bundle.main.loadNibNamed("HelpSectionHeader", owner: self, options: nil)?.first as! HelpSectionHeader
        view.tag = section + 2000
        view.isSelect = flagArray[section] as! Bool
        view.spreadBlock = {(index : NSInteger,isSelected : Bool) in
            print(index)
            let ratio : NSInteger = index - 2000
            if self.flagArray[ratio] as! Bool{
                self.flagArray[ratio] = false
            }else{
                self.flagArray[ratio] = true
            }
            self.tableView.reloadSections(IndexSet.init(integer: index - 2000), with: UITableViewRowAnimation.automatic)
        }
        
        view.titleLabel.text = sentionTitles[section]
        
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
}
