//
//  LSNavigationController.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

class LSNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        self.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
    }
    
    private func setupUI() {
//        navigationBar.shadowImage = UIImage()//导航栏底部的横线
        navigationBar.backIndicatorImage = #imageLiteral(resourceName: "arrow_right_nav_back")
        navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "arrow_right_nav_back")
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.color("#FFFFFF")
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.color("#000000"), NSAttributedString.Key.font: UIFont.mediumFont(19)]
//        navigationBar.tintColor = UIColor.color("#FFFFFF")//返回按钮的字体颜色
//        UIBarButtonItem.appearance().
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension LSNavigationController: UIGestureRecognizerDelegate,UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        //设置侧滑返回是否可用
        if navigationController.viewControllers.count == 1 {
            //如果是 rootViewController 就关闭手势响应
            self.interactivePopGestureRecognizer?.isEnabled = false
        }else{
            if viewController.isKind(of: LSViewController.self){
                let vc:LSViewController = viewController as! LSViewController
                self.interactivePopGestureRecognizer?.isEnabled = vc.popGestureEnable
            }else{
                self.interactivePopGestureRecognizer?.isEnabled = true
            }
        }
        
    }
 
}
