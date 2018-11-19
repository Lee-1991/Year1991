//
//  LSSettingViewController.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

class LSSettingViewController: LSViewController {
    
    var viewModel = APSettingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupUI() {
        title = "设置"
        self.view.addSubview(tableView)
    }
    
    fileprivate lazy var tableView: UITableView = {
        let view = UITableView(frame: self.view.bounds, style: .grouped)
        view.delegate = self
        view.dataSource = self
        view.register(APMineNormalCell.self, forCellReuseIdentifier: NSStringFromClass(APMineNormalCell.self))
        return view
    }()
    
}

extension LSSettingViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingDatas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return APMineNormalCell.heightOfCell()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(APMineNormalCell.self), for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? APMineNormalCell {
            let cellModel = viewModel.settingDatas[indexPath.row]
            cell.setData(cellModel)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
//            APPageJumpManager.pushToAboutVC()
            break
        case 1:
            alertViewAlert(title: "是否退出登录？", message: nil, leftName: "退出", rightName: "取消", leftHandler: { (action) in
//                let rootVC = APLoginViewController()
//                let rootNav = APNavigationController(rootViewController: rootVC)
//                UIApplication.shared.keyWindow?.rootViewController = rootNav
            }, rightHandler: nil)
        default:
            break
        }
    }
}

extension LSSettingViewController {
    /// 提示框，有标题、内容的样式
    func alertViewAlert(title:String?,message:String?,leftName:String,rightName:String,leftHandler: ((UIAlertAction) -> Swift.Void)? = nil,rightHandler: ((UIAlertAction) -> Swift.Void)? = nil){
        
        let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if let title = title {
            //标题字体样式（红色，字体放大）
            let titleFont = UIFont.mediumFont(17)
            let titleAttribute = NSMutableAttributedString.init(string: title)
            titleAttribute.addAttributes([NSAttributedString.Key.font:titleFont,
                                          NSAttributedString.Key.foregroundColor:UIColor.color("#000000")],
                                         range:NSMakeRange(0, title.count))
            vc.setValue(titleAttribute, forKey: "attributedTitle")
        }
        
        if let message = message {
            //内容
            let messageAtr = NSMutableAttributedString(string: message)
            messageAtr.addAttribute(NSAttributedString.Key.font, value: UIFont.font(15), range: NSRange(location: 0, length: message.count))
            messageAtr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.color(0xababab), range: NSRange(location: 0, length: message.count))
            vc.setValue(messageAtr, forKey: "attributedMessage")
        }
        
        let actionLeft = UIAlertAction(title: leftName, style: .default) { (action) in
            leftHandler?(action)
        }
        actionLeft.setValue(UIColor.color("#000000"), forKey:"titleTextColor")
        vc.addAction(actionLeft)
        
        let actionRight = UIAlertAction(title: rightName, style: .default) { (action) in
            rightHandler?(action)
        }
        actionRight.setValue(UIColor.color("#E18D03"), forKey:"titleTextColor")
        vc.addAction(actionRight)
        
        self.present(vc, animated: true, completion: nil)
    }
}
