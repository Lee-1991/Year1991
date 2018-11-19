//
//  LSSecondViewController.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

class LSSecondViewController: LSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContentView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hidesBottomBarWhenPushed = false
    }
    
    private func setupContentView() {
        view.addSubview(indicator)
        indicator.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    lazy var indicator: LSIndicatorView = {
        let view = LSIndicatorView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50))
        view.backgroundColor = UIColor.white
        view.delegate = self
        view.itemNames = ["First","Second","Third","Second","Third"]
        view.contentOffsetY = 6
        view.contentToSide = 20
        view.refreshContentUI()
        return view
    }()


}

extension LSSecondViewController: LSIndicatorViewDelegate {
    func indicatorViewSelect(index: Int) {
        LSHUD.showInfo("index:\(index)")
        self.view.backgroundColor = UIColor.randomColor()
    }
}
