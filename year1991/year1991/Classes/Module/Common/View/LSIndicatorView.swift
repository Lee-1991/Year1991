//
//  LSIndicatorView.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//
//  tab切换器
//  使用indicator的时候，设置完参数需要调用refreshContentUI()

/*
 支持横竖屏切换;
 itemWidth 宽度 由item数量、itemMargin与contentToSide共同决定;
 */

import UIKit

protocol LSIndicatorViewDelegate {
    
    /// 选中项位置
    func indicatorViewSelect(index: Int)
}

fileprivate var indicatorWidth = UIScreen.main.bounds.size.width

class LSIndicatorView: UIView {
    
    var delegate: LSIndicatorViewDelegate?
    
    /// 边距
    var contentToSide: CGFloat = 0
    
    /// y轴距离
    var contentOffsetY: CGFloat = 0
    
    /// 宽度 由item数量与itemMargin决定
    fileprivate var itemWidth: CGFloat = 50
    
    /// 高度
    var itemHeight: CGFloat = 44
    
    /// 间距
    var itemMargin: CGFloat = 0
    
    /// 字体颜色
    var itemColor: UIColor = UIColor.gray
    
    /// 选中的字体颜色
    var itemSelectedColor: UIColor = UIColor.black
    
    /// 字号
    var itemFont: UIFont = UIFont.systemFont(ofSize: 17)
    
    /// 选中的字号
    var itemSelectedFont: UIFont = UIFont.systemFont(ofSize: 17)
    
    /// 下划线宽度
    var selectedLineWidth: CGFloat = 20
    
    /// 下划线颜色
    var selectedLineColor: UIColor = UIColor.darkGray
    
    var itemNames = [String]()
    
    /// 选中的位置
    var selectedIndex = 0
    
    fileprivate var selectedItem: UIButton?
    
    fileprivate let itemTag = 1991
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange(_:)), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(UIDevice.orientationDidChangeNotification)
    }
    
    // 基础UI
    private func setupDefaultUI() {
        addSubview(separateLine)
        addSubview(selectedLine)
        
        separateLine.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    ///  刷新内容页面
    func refreshContentUI(_ withAction: Bool = true) {
        // 1.移除原有内容
        _ = self.subviews.map{
            $0.removeFromSuperview()
        }
        // 2.添加基础UI
        setupDefaultUI()
        // 3.item绘制
        var offsetX: CGFloat = contentToSide
        let offsetY: CGFloat = contentOffsetY
        let itemCount = CGFloat(itemNames.count)
        self.itemWidth = (indicatorWidth - contentToSide*2 - itemMargin*(itemCount-1))/itemCount
        let margin: CGFloat = itemMargin
        
        for item in itemNames.enumerated() {
            
            let button = UIButton(frame: CGRect(x: offsetX, y: offsetY, width: itemWidth, height: itemHeight))
            button.tag = itemTag + item.offset
            button.setTitleColor(itemColor, for: .normal)
            button.setTitleColor(itemSelectedColor, for: .selected)
            button.setTitle(item.element, for: .normal)
            button.titleLabel?.font = itemFont
            button.addTarget(self, action: #selector(onClickItem(_:)), for: .touchUpInside)
            addSubview(button)
            
            if item.offset == selectedIndex {
                if withAction {
                    self.onClickItem(button)
                } else {
                    self.updateSelectedUI(button)
                }
            }
            offsetX += (itemWidth + margin)
        }
    }
    
    lazy var selectedLine: UIView = {
        let view = UIView()
        view.backgroundColor = selectedLineColor
        return view
    }()
    
    lazy var separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
}

// MARK: - 逻辑处理
extension LSIndicatorView {
    
    /// item选中事件
    @objc fileprivate func onClickItem(_ sender:UIButton) {
        updateSelectedUI(sender)
        
        selectedIndex = sender.tag - itemTag
        delegate?.indicatorViewSelect(index: selectedIndex)
    }
    
    ///  更新选中状态的UI
    fileprivate func updateSelectedUI(_ button: UIButton) {
        
        selectedItem?.titleLabel?.font = itemFont
        selectedItem?.isSelected = false
        button.titleLabel?.font = itemSelectedFont
        button.isSelected = true
        selectedItem = button
        selectedIndex = button.tag - itemTag
        
        selectedLine.snp.remakeConstraints { (make) in
            make.centerX.equalTo(button)
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: selectedLineWidth, height: 3))
        }
    }
    
    // 设备横竖屏变化的通知事件
    @objc fileprivate func deviceOrientationDidChange(_ notify: Notification){
        indicatorWidth = UIScreen.main.bounds.size.width
        refreshContentUI(false)
    }
    
}
