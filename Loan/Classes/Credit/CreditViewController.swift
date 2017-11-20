//
//  CreditViewController.swift
//  Loan
//
//  Created by lau Andy on 2017/11/7.
//  Copyright © 2017年 lau Andy. All rights reserved.
//

import UIKit
import SnapKit
import UserNotifications
import Contacts
import MBProgressHUD

class CreditViewController: UIViewController {

    
    @IBOutlet weak var creditView: UIView!
    @IBOutlet weak var creditImageView: UIImageView!
    
    @IBOutlet weak var lendBtn: UIButton!
    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!

    @IBOutlet weak var loadBtnTopConstraint: NSLayoutConstraint!
    /// 银行卡认证
    @IBOutlet weak var bankApproveImg: UIImageView!
    /// 个人身份认证（个人信息和身份证以及人脸识别）
    @IBOutlet weak var personApproveImg: UIImageView!
    /// 芝麻信用认证
    @IBOutlet weak var zhimaApproveImg: UIImageView!
    /// 运营商认证
    @IBOutlet weak var operatorApproveImg: UIImageView!
    
    fileprivate var creditStrLab: UILabel!  // 中等信用
    fileprivate var creditLab: LCCounterLabel!  // 额度 20000
    fileprivate var gradientLayer:CAGradientLayer!  //渐变层
    
    fileprivate var animateImage: UIImageView! // 光标图
    
    // 角度转弧度
    fileprivate let startAng=135.0/180.0*Double.pi.cgFloat //外圈（底色圈）开始位置
    fileprivate let endAng=45.0/180.0*Double.pi.cgFloat    //外圈（底色圈）结束位置
    fileprivate let allAng=270.0/180.0*Double.pi.cgFloat   //外圈（底色圈）角度
    
    fileprivate var ContactsData: [AddressBookModel] = []
    fileprivate var contents = [Any]() // 通讯录信息
    
    fileprivate var creditModel: CreditModel? // 信用model
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        animateImage.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        saveAddress()
        fetchData()
        
        if !isLogin().0 {
            /// 只是现实额度 并进行动画
            creditLab.countFrom(start: 350, to: 550, duration: 3)
//            setdashBoardView()
            setLayer()
        }

        /// 表示登录成功在请求数据
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: Notification.Name.Task.loginSuccess, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Action
    
    /// 申请借款
    @IBAction func requestLoan(_ sender: UIButton) {
        
        var param = [String: Any]()
        param["customerId"] = 2
        param["communicationName"] = "姓名"
        param["communicationTel"] = "电话号码: 10086"
        
        var parameters = [String: Any]()
        parameters["lists"] = contents
        
        printLog("请求通讯录参数----\(parameters)")
        
        NetworkTools.saveAddressBook(parameters) { (flag) in
            
            if flag {
                
                DispatchQueue.main.async {
                     MBProgressHUD.showMessage("上传通讯录成功", toView: self.view)
                }
 
            }
            
        }
        
    }
    
    /// 银行卡认证
    @IBAction func bankApprove(_ sender: UIButton) {
        printLog("银行卡认证")
    }
    
    /// 个人认证
    @IBAction func personApprove(_ sender: UIButton) {
        
        if creditModel?.isTelAuthentication == false {
            showMsg("请先完成银行卡认证")
            return
        }
        printLog("个人认证")
    }
    
    /// 芝麻认证
    @IBAction func zhimaApprove(_ sender: UIButton) {
        
        if creditModel?.isTelAuthentication == false {
            showMsg("请先完成银行卡认证")
            return
        }
        
        if creditModel?.isFaceRecognition == false {
            showMsg("请先完成个人信息认证")
            return
        }
        
        printLog("芝麻认证")
    }
    
    /// 运营商认证
    @IBAction func operatorApporve(_ sender: UIButton) {
        
        if creditModel?.isTelAuthentication == false {
            showMsg("请先完成银行卡认证")
            return
        }
        
        if creditModel?.isFaceRecognition == false {
            showMsg("请先完成个人信息认证")
            return
        }
        
        if creditModel?.isSesameCredit == false {
           showMsg("请先完成个人信息认证")
            return
        }
        
        printLog("运营商认证")
    }
    
    fileprivate func showMsg(_ text: String) {
        let alertController = UIAlertController(title: "",
                                                message: text,
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title:"确定", style: .default, handler:nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

extension CreditViewController {
    
    fileprivate func setupUI() {
        lendBtn.cuttingCorner(radius: lendBtn.height/2)
        lendBtn.setupBorder(width: 2, color: UIColor.white)
        
        // 背景渐变色
        let colors = [UIColor(r: 95, g: 243, b: 224).cgColor,
                      UIColor(r: 93, g: 143, b: 236).cgColor]
        //创建CAGradientLayer对象
        gradientLayer = CAGradientLayer()
        //设置初始渐变色
        gradientLayer.colors = colors
        //每种颜色所在的位置
        gradientLayer.locations = [0.0,1.0]
        
        //设置其CAGradientLayer对象的frame，并插入view的layer
        if IS_IPhone_X {
            topLayoutConstraint.constant = -44
            gradientLayer.frame = CGRect(x: 0, y: -24, width: kScreen_w, height: kScreen_h*0.4)
            
        }else{
            topLayoutConstraint.constant = -20
            gradientLayer.frame = CGRect(x: 0, y: -20, width: kScreen_w, height: kScreen_h*0.4)
        }
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        if IS_IPhone5_5s {
           loadBtnTopConstraint.constant = 0
        }
        
        creditLab = LCCounterLabel(frame: CGRect.zero, type: .Int)
        creditView.addSubview(creditLab)
        creditLab.textColor = UIColor(hexString: "FFC832")
        creditLab.font = UIFont.boldSystemFont(ofSize: 30)
        
        creditStrLab = UILabel()
        creditView.addSubview(creditStrLab)
        creditStrLab.text = "信用优"
        creditStrLab.textColor = UIColor(hexString: "FFC832")
        creditStrLab.font = UIFont.systemFont(ofSize: 12)
        
        creditLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.creditView)
            make.centerY.equalTo(self.creditView)
        }
        
        creditStrLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(creditLab).offset(15)
            make.centerX.equalTo(self.view)
        }
    }
    
    fileprivate func setLayer() {
        
        let layRect = CGRect(x: 0, y: 0, width: kScreen_w, height: kScreen_h*0.4)
        
        printLog("-------\(layRect)")
        
        
        let lay = LayView(frame: layRect, endAngle: CGFloat(20/180.0*Double.pi))
        self.creditView.addSubview(lay)
        lay.setAnimated()
    }
    
    fileprivate func setdashBoardView() {
        
        let center = CGPoint(x: kScreen_w/2, y: kScreen_h * 0.4 / 2) //creditView.center
       
        /// 路径1
        let path = UIBezierPath()
        
        if IS_IPhone5_5s {
            path.addArc(withCenter: center, radius: 60, startAngle: CGFloat(startAng), endAngle: CGFloat(endAng), clockwise: true)
        }else {
          path.addArc(withCenter: center, radius: 75, startAngle: CGFloat(startAng), endAngle: CGFloat(endAng), clockwise: true)
        }

        /// 动画路径
        let apath = UIBezierPath()
        
        if IS_IPhone5_5s {
           apath.addArc(withCenter: center, radius: 60, startAngle: CGFloat(startAng), endAngle: CGFloat(endAng) - endAng, clockwise: true)
        }else{
          apath.addArc(withCenter: center, radius: 75, startAngle: CGFloat(startAng), endAngle: CGFloat(endAng) - endAng, clockwise: true)
        }
        
        
        
        /// 渲染图层
        let pathLayer = CAShapeLayer()
        pathLayer.path = path.cgPath
        pathLayer.lineCap = kCALineCapRound
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.white.withAlphaComponent(0.7).cgColor
        pathLayer.lineWidth = 2
        
        /// 帧动画对象
        let orbit = CAKeyframeAnimation(keyPath:"position")
        orbit.calculationMode = kCAAnimationPaced
        orbit.fillMode = kCAFillModeForwards
        orbit.rotationMode = kCAAnimationRotateAuto  // 根据路径自动旋转 kCAAnimationCubic 
        orbit.isRemovedOnCompletion = false  // 是否在动画完成后从 Layer 层上移除  回到最开始状态
        orbit.duration = 3
        orbit.path = apath.cgPath
        
        
        animateImage = UIImageView(frame: CGRect(x: 0, y: 100, width: 8, height: 8))
        animateImage.image = UIImage(named: "credit_hight")?.withRenderingMode(.alwaysOriginal)
        
        creditView.layer.addSublayer(pathLayer)
        creditView.addSubview(animateImage)
        /// 最后添加旋转动画
        animateImage.layer.add(orbit, forKey: nil)
        
        
        /// 内圈虚线
        let path1 = UIBezierPath()
        if IS_IPhone5_5s {
           path1.addArc(withCenter: center, radius: 55, startAngle: CGFloat(startAng), endAngle: CGFloat(endAng), clockwise: true)
        }else {
            path1.addArc(withCenter: center, radius: 70, startAngle: CGFloat(startAng), endAngle: CGFloat(endAng), clockwise: true)
        }
        

        let pathLayer1 = CAShapeLayer()
        pathLayer1.lineCap = kCALineCapRound
        pathLayer1.fillColor = UIColor.clear.cgColor
        pathLayer1.strokeColor = UIColor.white.withAlphaComponent(0.6).cgColor
        pathLayer1.lineWidth = 2
        pathLayer1.lineDashPhase = 0
        // 3=线的宽度 1=每条线的间距
        pathLayer1.lineDashPattern = [NSNumber(value: 1), NSNumber(value: 5)]
        
        let p = CGMutablePath()
        if IS_IPhone5_5s {
            p.addArc(center: center, radius: 55, startAngle: CGFloat(startAng), endAngle: CGFloat(endAng), clockwise: false)
        }else {
            p.addArc(center: center, radius: 70, startAngle: CGFloat(startAng), endAngle: CGFloat(endAng), clockwise: false)
        }
        
        pathLayer1.path = p
        creditView.layer.addSublayer(pathLayer1)
        
    }
    
    /// 保存通讯录
    fileprivate func saveAddress() {
        
        // 检查权限状态
        let status: CNAuthorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
            
        case .authorized:
            print("能够自由访问联系人")
            self.loadContactsData()
            
        case .notDetermined, .denied, .restricted:
            print("不允许应用访问联系人数据")
            
            let alertController = UIAlertController(title: "通讯录访问受限",
                                                    message: "点击“设置”，允许访问您的通讯录",
                                                    preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title:"取消", style: .cancel, handler:nil)
            
            let settingsAction = UIAlertAction(title:"设置", style: .default, handler: {
                (action) -> Void in
                
                let url = URL(string: UIApplicationOpenSettingsURLString)
                if let url = url, UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url, options: [:],
                                                  completionHandler: {
                                                    (success) in
                        })
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    fileprivate func loadContactsData() {
        
        //获取授权状态
        let status = CNContactStore.authorizationStatus(for: .contacts)
        //判断当前授权状态
        guard status == .authorized else { return }
        
        //创建通讯录对象
        let store = CNContactStore()
        
        //获取Fetch,并且指定要获取联系人中的什么属性
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNicknameKey,
                    CNContactOrganizationNameKey, CNContactJobTitleKey,
                    CNContactDepartmentNameKey, CNContactNoteKey, CNContactPhoneNumbersKey,
                    CNContactEmailAddressesKey, CNContactPostalAddressesKey,
                    CNContactDatesKey, CNContactInstantMessageAddressesKey
        ]
        
        //创建请求对象
        //需要传入一个(keysToFetch: [CNKeyDescriptor]) 包含CNKeyDescriptor类型的数组
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])

        //遍历所有联系人
        do {
            try store.enumerateContacts(with: request, usingBlock: {
                (contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>) -> Void in
                
                //获取姓名
                let lastName = contact.familyName
                let firstName = contact.givenName
                
                //                print("姓名：\(lastName)\(firstName)")
                
                //获取电话号码
                if contact.phoneNumbers.count > 0 {
                    let phone = contact.phoneNumbers[0]
                    let value = phone.value.stringValue
                    //                    print("电话：\(value)")
                    
                    //                    let model = AddressBookModel()
                    //                    model.communicationName = "姓名：\(lastName)\(firstName)"
                    //                    model.communicationTel = "电话：\(value)"
                    //                    ContactsData.append(model)
                    
                    
                    let model: [String : Any] = ["communicationName": "\(lastName)\(firstName)",
                        "communicationTel": "\(value)",
                        "customerId": 2]
                    
                    self.contents.append(model)
                }
                
                //                for phone in contact.phoneNumbers {
                //                    //获得标签名（转为能看得懂的本地标签名，比如work、home）
                //                    var label = "未知标签"
                //                    if phone.label != nil {
                //                        label = CNLabeledValue<NSString>.localizedString(forLabel:phone.label!)
                //                    }
                //
                //                    //获取号码
                //                    let value = phone.value.stringValue
                //                    print("电话：\(label)：\(value)")
                //                }
                
            })
        } catch {
            print(error)
        }
        
        printLog("通讯录-----\(contents)")
    }
    
    @objc fileprivate func fetchData() {
        
        if isLogin().0 {
            
            NetworkTools.fetchCreditInfo(isLogin().1) { (creditModel) in
                
                /// 用户判断用户认证了那些选项
                self.creditModel = creditModel
                
                DispatchQueue.main.async {
                    self.setupData(creditModel)
                }
                
            }
        }
    }
    
    fileprivate func setupData(_ model: CreditModel) {
        
        var startNum: Int = 0
        var endNum: Int = 0
        
        /// 预防得到nil 程序闪退
        if let start = model.creditScore {
            startNum = start + 350
            endNum = start + 550
            printLog("信用额度分----\(start)")
        }else {
            startNum = 350
            endNum = 550
            
        }
        
        /// 只是现实额度 并进行动画
        creditLab.countFrom(start: startNum.float, to: endNum.float, duration: 3)
        setdashBoardView()
        
        bankApproveImg.image = model.isCardAuthentication == true ? UIImage(named: "credit_approve") : UIImage(named: "credit_unapprove")
        personApproveImg.image = model.isCardAuthentication == true ? UIImage(named: "credit_approve") : UIImage(named: "credit_unapprove")
        zhimaApproveImg.image = model.isSesameCredit == true ? UIImage(named: "credit_approve") : UIImage(named: "credit_unapprove")
        operatorApproveImg.image = model.isCardAuthentication == true ? UIImage(named: "credit_approve") : UIImage(named: "credit_unapprove")
        
    }

}
