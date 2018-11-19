//
//  LSAboutViewController.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//
//  关于页面

import UIKit

class LSAboutViewController: LSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    

    private func setupUI(){
        title = "关于"
    }

}
