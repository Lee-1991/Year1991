//
//  LSMineViewController.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//
//  个人中心

import UIKit

class LSMineViewController: LSViewController {

    var viewModel = APMineViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeNavigarionStyle(.profile)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        changeNavigarionStyle(.main)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hidesBottomBarWhenPushed = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupUI() {
//        showNavRightBtn = true
//        navRightBtn.setImage(#imageLiteral(resourceName: "mine_edit_profile"), for: .normal)
        view.addSubview(tableView)
    }
    
//    override func navigationRightBtnAction(_ sender: UIButton) {
//        let vc = APSettingViewController()
//        vc.title = "编辑"
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kNavBarHeight - kTabBarHeight))
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.color("#F5F5F9")
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.register(APMineProfileCell.self, forCellReuseIdentifier: NSStringFromClass(APMineProfileCell.self))
        view.register(APMineNormalCell.self, forCellReuseIdentifier: NSStringFromClass(APMineNormalCell.self))
        return view
    }()
    
}

//MARK: -tableView
extension LSMineViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.setctionCount
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 {
            return 20
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
//        view.backgroundColor = UIColor.color("#F5F5F9")
        return view
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
//        case 1:
//            return viewModel.mineDatas.count
        case 1:
            return viewModel.settingDatas.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return APMineProfileCell.heightOfCell()
        } else {
            return APMineNormalCell.heightOfCell()
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(APMineProfileCell.self), for: indexPath)
        } else {
            return tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(APMineNormalCell.self), for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? APMineNormalCell {
//            if indexPath.section == 1 {
//                let cellModel = viewModel.mineDatas[indexPath.row]
//                cell.setData(cellModel)
//            }else {
//            }
            let cellModel = viewModel.settingDatas[indexPath.row]
            cell.setData(cellModel)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
//        var cellModel: APMineNormalCellViewModel?
//        if indexPath.section == 1 {
//            cellModel = viewModel.mineDatas[indexPath.row]
//            let vc = APSettingViewController()
//            vc.title = cellModel?.title
//            navigationController?.pushViewController(vc, animated: true)
//        } else if indexPath.section == 2 {
        
//        cellModel = viewModel.settingDatas[indexPath.row]
//            if cellModel?.title == "使用帮助" {
//                APPageJumpManager.pushToWebVC("使用帮助", linkUrl: "https://www.baidu.com")
//            } else {
//            }
//        }
        if indexPath.section == 1 {
            
            let vc = LSSettingViewController()
            //        vc.title = cellModel?.title
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension LSMineViewController {
}
