//
//  LSFirstViewController.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

class LSFirstViewController: LSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContentView()
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hidesBottomBarWhenPushed = false
    }
    
    private func setupContentView() {
        view.addSubview(cycleView)
    }

    lazy var cycleView: LSCycleView = {
        let view = LSCycleView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 240))
        view.delegate = self
        view.cycleInterval = 3.0
        view.pageIndicatorTintColor = .lightGray
        view.currentPageIndicatorTintColor = .orange
        view.sourceImages = [UIImage(named: "tabbar_first_normal"),
                             UIImage(named: "tabbar_first_selected"),
                             UIImage(named: "tabbar_second_normal"),
                             UIImage(named: "tabbar_second_selected"),
                             UIImage(named: "tabbar_third_normal"),
                             UIImage(named: "tabbar_third_selected"),]
        return view
    }()
}

extension LSFirstViewController: LSCycleViewDelegate {
    func cycleViewDidClick(index: Int) {
        print("cycleViewDidClick index:\(index)")
    }
}

