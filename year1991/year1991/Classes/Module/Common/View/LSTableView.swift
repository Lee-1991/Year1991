//
//  LSTableView.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

protocol APTableViewRefreshDelegate {
    
    func tableViewRefreshAction()
    
    func tableViewLoadmoreAction()
}

class APTableView: UITableView {
    
    var refreshDelegate: APTableViewRefreshDelegate?
    
    var haveDataView: Bool? {
        didSet {
            if haveDataView == true {
                addSubview(dataView)
                dataView.snp.makeConstraints { (make) in
                    make.top.equalToSuperview()
                    make.left.equalToSuperview()
                    make.right.equalToSuperview()
                    make.bottom.equalToSuperview()
                }
            } else {
                dataView.removeFromSuperview()
            }
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var touchTableBlock: (()->Void)?
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchTableBlock?()
    }
    
    lazy var dataView: LSDataView = {
        let view = LSDataView(frame: self.bounds)
        return view
    }()
}

extension APTableView {
    
    fileprivate func setUI() {
        tableFooterView = UIView(frame: CGRect.zero)
        setupRefreshHeader()
        setupLoadmoreFooter()
    }
    
    private func setupRefreshHeader(){
        let mjRefreshHeader = MJRefreshNormalHeader { [weak self] in
            if let weakSelf = self {
                weakSelf.refreshDelegate?.tableViewRefreshAction()
            }
        }
        mjRefreshHeader?.setTitle("下拉刷新", for: .idle)
        mjRefreshHeader?.setTitle("释放更新", for: .pulling)
        mjRefreshHeader?.setTitle("加载中...", for: .refreshing)
        mjRefreshHeader?.stateLabel.font = UIFont.systemFont(ofSize: 14)
        mjRefreshHeader?.lastUpdatedTimeLabel.isHidden = true
        self.mj_header = mjRefreshHeader
    }
    
    private func setupLoadmoreFooter(){
        let mjRefreshFooter = MJRefreshBackNormalFooter { [weak self] in
            if let weakSelf = self {
                weakSelf.refreshDelegate?.tableViewLoadmoreAction()
            }
        }
//        let mjRefreshFooter = MJRefreshAutoNormalFooter { [weak self] in
//            if let weakSelf = self {
//                weakSelf.refreshDelegate?.tableViewLoadmoreAction()
//            }
//        }
//        mjRefreshFooter?.stateLabel.font = UIFont.systemFont(ofSize: 14)
        self.mj_footer = mjRefreshFooter
    }
}

// MARK: -外部调用
extension APTableView {
    
    /// 下拉刷新
    public func refreshWithAnimation() {
        mj_header.beginRefreshing()
    }
    
    /// 结束刷新
    ///
    /// - Parameters:
    ///   - isRefresh: true = 下拉刷新,false = 上拉加载
    ///   - hasMore: 是否还有更多数据
    public func compeletLoading(_ isRefresh: Bool, hasMore: Bool = true) {
        if isRefresh {
            mj_header.endRefreshing()
        } else {
            mj_footer.endRefreshing()
        }
        
        if hasMore == false {
            mj_footer.endRefreshingWithNoMoreData()
        }
    }
}

