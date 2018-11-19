//
//  LSViewController.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

class LSViewController: UIViewController {
    
    
    private lazy var backBtn: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "arrow_right_nav_back"), for: .normal)
        return button
    }()
    
    lazy var navRightBtn: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 22)
        button.addTarget(self, action: #selector(navigationRightBtnAction(_:)), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        button.setTitleColor(UIColor.color("#E18D03"), for: .normal)
        button.setTitleColor(UIColor.color("#838383"), for: .disabled)
        button.titleLabel?.font = UIFont.font(14)
        return button
    }()
    
    /// 侧滑返回是否可用，默认true
    var popGestureEnable = true
    /// 是否展示导航栏
    var showNavgationBar: Bool? {
        didSet {
            navigationController?.navigationBar.isHidden = !(showNavgationBar ?? true)
        }
    }
    
    ///是否展示导航栏右侧按钮
    var showNavRightBtn:Bool = false {
        didSet{
            if showNavRightBtn {
                navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navRightBtn)
            }
            
            navRightBtn.isHidden = !showNavRightBtn
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//            UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//            UIBarButtonItem(customView: backBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hidesBottomBarWhenPushed = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 导航栏右侧按钮事件
    /// 在需要的页面重写
    @objc func navigationRightBtnAction(_ sender:UIButton){}

    func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func popSelf(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    /// 更改导航栏样式
    ///
    /// - Parameters:
    ///   - tintColor: 背景色
    ///   - titleColor: 标题颜色
    ///   - titleFont: 标题字体大小
    private func changeNavigationBar(_ tintColor: UIColor, titleColor: UIColor, titleFont: UIFont = UIFont.mediumFont(18)) {
        self.navigationController?.navigationBar.barTintColor = tintColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: titleFont]
    }
    
    enum NavigationStyle: String {
        case main = "main"
        case profile = "profile"
    }
    
    /// 更改导航栏样式
    func changeNavigarionStyle(_ style: NavigationStyle){
        switch style {
        case .main:
            changeNavigationBar(UIColor.color("#FFFFFF"), titleColor: UIColor.color("#444E53"))
            self.navigationController?.navigationBar.shadowImage = UIImage.image(UIColor.color(r: 220, g: 222, b: 223), viewSize: CGSize(width: kScreenWidth, height: 1))
        case .profile:
            changeNavigationBar(UIColor.color(r: 238, g: 146, b: 55), titleColor: UIColor.color("#FFFFFF"))
            self.navigationController?.navigationBar.shadowImage = UIImage.image(UIColor.color(0xFFFFFF, alpha: 0.0), viewSize: CGSize(width: kScreenWidth, height: 1))
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
