//
//  LSIndicatorView.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//
//  tab切换
//  使用indicator的时候，设置完参数需要调用refreshContentUI()

import UIKit

protocol LSIndicatorViewDelegate {
    
    func indicatorViewSelect(index: Int)
}

class LSIndicatorView: UIView {
    
    var delegate: LSIndicatorViewDelegate?
    
    /// 左边距
    var itemToLeft: CGFloat = 60
    
    /// 间距
//    var itemMargin: CGFloat =  100
    
    /// y轴距离
    var itemOffsetY: CGFloat = 0
    
    /// 宽度
    var itemWidth: CGFloat = 86
    
    /// 高度
    var itemHeight: CGFloat = 48
    
    /// 字体颜色
    var itemColor: UIColor = UIColor.color("#000000")
    
    /// 选中的字体颜色
    var itemSelectedColor: UIColor = UIColor.color("#E18D03")
    
    /// 字号
    var itemFont: UIFont = UIFont.font(17)
    
    /// 选中的字号
    var itemSelectedFont: UIFont = UIFont.font(17)
    
    /// 下划线宽度
    var selectedLineWidth: CGFloat = 86
    
    /// 下划线颜色
    var selectedLineColor: UIColor = UIColor.color("#E18D03")
    
    var itemNames = [String]()
    
    /// 选中的位置
    var selectedIndex = 0
    
    fileprivate var selectedItem: UIButton?
    
    fileprivate let itemTag = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaultUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDefaultUI() {
        addSubview(separateLine)
        addSubview(selectedLine)
        
        separateLine.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
//        selectedLine.snp.makeConstraints { (make) in
//            make.left.equalTo(itemToLeft)
//            make.bottom.equalToSuperview()
//            make.width.equalTo(selectedLineWidth)
//            make.height.equalTo(3)
//        }
    }
    
    func refreshContentUI() {
        
        var offsetX: CGFloat = itemToLeft
        let offsetY: CGFloat = itemOffsetY
        let itemCount = CGFloat(itemNames.count)
        let margin: CGFloat = (kScreenWidth - itemToLeft*2 - itemWidth * itemCount)/(itemCount - 1)
        
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
                
                selectedLine.snp.makeConstraints { (make) in
                    make.centerX.equalTo(button)
                    make.bottom.equalToSuperview()
                    make.size.equalTo(CGSize(width: selectedLineWidth, height: 3))
                }
                
                button.isSelected = true
                selectedItem = button
                self.onClickItem(button)
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
        let view = UIView.initSeparateLine()
        return view
    }()
    
}

// MARK: - 逻辑处理
extension LSIndicatorView {
    
    @objc fileprivate func onClickItem(_ sender:UIButton) {
        
        selectedItem?.titleLabel?.font = itemFont
        selectedItem?.isSelected = false
        sender.titleLabel?.font = itemSelectedFont
        sender.isSelected = true
        selectedItem = sender
        
        selectedLine.snp.remakeConstraints { (make) in
            make.centerX.equalTo(sender)
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: selectedLineWidth, height: 3))
        }
//        selectedLine.snp.updateConstraints { (make) in
//            make.centerX.equalTo(sender)
//        }
        
        selectedIndex = sender.tag - itemTag
        
        delegate?.indicatorViewSelect(index: selectedIndex)
        
    }
    
}
