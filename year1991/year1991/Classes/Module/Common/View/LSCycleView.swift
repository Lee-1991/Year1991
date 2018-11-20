//
//  LSCycleView.swift
//  year1991
//
//  Created by Lee on 2018/11/20.
//  Copyright © 2018 辛未年. All rights reserved.
//
//  轮播器
/**
 使用 collectionView 实现轮播图
 创建collectionView, 设置3个section , 每个section中有相同的 items.
 默认显示中间那一组(第2组)的 section
 当滑动到 第2组的最后一个 item 时, 滚动显示第3组的第一个item（与第2组第一个相同）
 当在第3组的第一个item 继续往后滚动时, 显示第2组的第2个item , 然后保持在第2组中往后滚动, 直到最后一个item 重复上面的步骤.
 无限滚动代码实现.
 逆向拉拽的思路同上.
 */


/**
 图片轮播器
 默认 直接通过图片赋值，使用时可根据实际情况修改图片赋值方式（比如使用：KingFisher框架）
 图片填充方式 .scaleAspectFill
 */

import UIKit

protocol LSCycleViewDelegate {
    /// 轮播点击事件
    ///
    /// - Parameter index: 点击的位置  从0开始
    func cycleViewDidClick(index: Int)
}

class LSCycleView: UIView {
    
    var delegate: LSCycleViewDelegate?
    /// 数据源
    var sourceImages = [UIImage?]() {
        didSet {
            pageControl.numberOfPages = sourceImages.count
            collectionView.reloadData()
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 1), at: .left, animated: false)
        }
    }
    /// 轮播频率 默认3.0
    var cycleInterval: TimeInterval = 3.0 {
        didSet {
            cycleTimerSwitch(false)
            cycleTimerSwitch(true)
        }
    }
    
    var pageIndicatorTintColor: UIColor? {
        didSet {
            pageControl.pageIndicatorTintColor = pageIndicatorTintColor
        }
    }
    
    var currentPageIndicatorTintColor: UIColor? {
        didSet {
            pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        }
    }
    
    // 轮播定时器
    fileprivate var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
        //添加定时器
        cycleTimerSwitch(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView() {
        addSubview(collectionView)
        addSubview(pageControl)
        
        self.addConstraint(NSLayoutConstraint(item: pageControl, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -10))
        self.addConstraint(NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
    }
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.frame.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let view = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = self.backgroundColor
        view.showsHorizontalScrollIndicator = false
        view.register(LSCycleViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(LSCycleViewCell.self))
        return view
    }()
    
    fileprivate lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = sourceImages.count
        control.hidesForSinglePage = true
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
}

//MARK: -内部逻辑
extension LSCycleView {
    // 轮播定时器开关
    fileprivate func cycleTimerSwitch(_ on: Bool) {
        if on {
            addTimer()
        } else {
            invalidateTimer()
        }
    }
    
    // 添加定时器
    private func addTimer() {
        timer = Timer(timeInterval: cycleInterval, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    // 关闭定时器
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc fileprivate func nextImage() {
        //获取当前indexPath
        let currentIndexPath = collectionView.indexPathsForVisibleItems.last!
        //获取中间那一组的indexPath
        let middleIndexPath = IndexPath(item: currentIndexPath.item, section: 1)
        //滚动到中间那一组
        collectionView.scrollToItem(at: middleIndexPath, at: .left, animated: false)
        
        var nextItem = middleIndexPath.item + 1
        var nextSection = middleIndexPath.section
        if nextItem == sourceImages.count {
            nextItem = 0
            nextSection += 1
        }
        collectionView.scrollToItem(at: IndexPath(item: nextItem, section: nextSection), at: .left, animated: true)
    }
}

// MARK: QMCycleView-CollectionView
extension LSCycleView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourceImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(LSCycleViewCell.self), for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? LSCycleViewCell {
            cell.imageView.image = sourceImages[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.cycleViewDidClick(index: indexPath.row)
    }
    
    //在这个方法中算出当前页数
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int((collectionView.contentOffset.x + (collectionView.bounds.width) * 0.5) / (collectionView.bounds.width))
        let currentPage = page % sourceImages.count
        pageControl.currentPage = currentPage
    }
    
    //在开始拖拽的时候移除定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        cycleTimerSwitch(false)
    }
    
    //结束拖拽的时候重新添加定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        cycleTimerSwitch(true)
    }
    
    //手动滑动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: 1), at: .left, animated: false)
    }
}

// MARK: QMCycleViewCell
fileprivate class LSCycleViewCell: UICollectionViewCell {
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: self.bounds)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
}
