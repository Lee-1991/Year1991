//
//  LSWebViewController.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit
import WebKit

class LSWebViewController: LSViewController {

    var titleStr = ""
    var linkUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webViewLoadRequst()
        self.setupContentView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.addSubview(webNavView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webNavView.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("APWebViewController is deinit")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webNavView.progressView.reloadInputViews()
    }
    
    private func webViewLoadRequst(){
        let url = URL(string: linkUrl)
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    @objc func webNavBackBtnAction(){
        if webView.canGoBack {
            webView.goBack()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupContentView(){
        webNavView.titleLbl.text = titleStr
        
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
    }
    
    
    //MARK: lazy
    lazy var webView: WKWebView = {
        //        let config = WKWebViewConfiguration()
        //        config.userContentController = WKUserContentController()
        //        config.preferences.javaScriptEnabled = true
        //        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        let view = WKWebView()
        view.navigationDelegate = self
        view.uiDelegate = self
        view.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        return view
    }()
    
    lazy var webNavView: LSWebNavigationView = {
        let view = LSWebNavigationView(frame: self.navigationController?.navigationBar.bounds ?? CGRect(x: 0, y: 0, width: kScreenWidth, height: kNavBarHeight))
        view.backBtn.addTarget(self, action: #selector(webNavBackBtnAction), for: .touchUpInside)
        return view
    }()
}


extension LSWebViewController:WKUIDelegate,WKNavigationDelegate{
    
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webNavView.progressView.progress = 0
        webNavView.progressView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hiddenProgressView(after: 0.3)
        self.webNavView.titleLbl.text = webView.title
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            
            webNavView.progressView.progress = Float(webView.estimatedProgress)
            if self.webView.estimatedProgress == 1 {
                //让这个进度的消失慢一些，一闪而过体验不太好
                self.hiddenProgressView(after: 0.3)
            }
        }
        
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        //        https://www.tencent.com/mobile/zh-cn/index.html -> 知识产权
        //        <a href="../../legal/html/zh-cn/index.html" target="_blank">知识产权</a>
        //不加这个的话，类似上面这样的相对路径就无法打开
        if navigationAction.targetFrame?.isMainFrame == false || navigationAction.targetFrame?.isMainFrame == nil {
            webView.load(navigationAction.request)
        }
        
        return nil;
    }
}

extension LSWebViewController{
    
    ///在一定时间以后隐藏进度条
    private func hiddenProgressView(after interval:TimeInterval){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+interval, execute: {
            self.webNavView.progressView.isHidden = true
        })
    }
}

class LSWebNavigationView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView(){
        
        self.backgroundColor = UIColor.color("#FFFFFF")
        
        self.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        self.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-11)
            make.width.equalTo(kScreenWidth*0.75)
        }
        
        self.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-14)
            make.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.addSubview(progressView)
    }
    
    //MARK: lazy

    /// 返回按钮
    lazy var backBtn: UIButton = {
        let button = UIButton()
        let img = #imageLiteral(resourceName: "arrow_right_nav_back")
        let backImg = img.withRenderingMode(.alwaysOriginal)
        button.setImage(backImg, for: .normal)
        return button
    }()
    
    /// 右边按钮
    lazy var rightBtn: UIButton = {
        let button = UIButton()
        button.contentMode = .right
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.font = UIFont.font(15)
        button.contentHorizontalAlignment = .right
        button.setTitleColor(UIColor.color("#FFFFFF"), for: .normal)
        return button
    }()
    
    /// 标题
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumFont(18)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.color("#444E53")
        return label
    }()
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView(frame: CGRect(x: 0, y: self.frame.size.height - 2, width: kScreenWidth, height: 2))
        view.trackTintColor = .white
        view.progressTintColor = UIColor.color(0xf58c7c)
        return view
    }()
}
