//
//  HCShowImageManager.swift
//  HCShowImage
//
//  Created by HCF on 15/12/30.
//  Copyright © 2015年 HCF. All rights reserved.
//

import UIKit
import Kingfisher

/**
 图片消息放大
 */
class HCShowImageManager: NSObject, HCImageScrollViewDelegate, UIScrollViewDelegate {
    ///scroll面板
    var scrollPanel: UIView!
    ///标签面板
    var markPanelView: UIView!
    ///scrollView
    var scrollView: UIScrollView!
    ///window
    var window: UIWindow!
    ///当前标签数
    var currentIndex: NSInteger!
    ///宽度
    var itemWidth: CGFloat!
    ///显示页数
    var pageLabel: UILabel!
    ///总页数
    var sumLabel: UILabel!
    ///功能
    var moreButton: UIButton!
    
    ///ActionSheet蒙版
    var backMarkView: UIView!
    
    ///保存按钮
    var saveButton: UIButton!
    
    ///取消按钮
    var cancelButton: UIButton!
    
    ///自定义ActionSheet
    var ActionSheet: UIView!
    
    ///图片网络路径
    var imageUrl: String!
    
    /// 图片网络路径
    var imageUrls = [String]()
    var imageViews = [UIImageView]()
    ///提示语
    var titleLabel: UILabel!
    
    let spaceWitdh = 10
    
    static let shared = HCShowImageManager()
    fileprivate override init() {
        window = (UIApplication.shared.delegate?.window)!
        scrollPanel = UIView(frame: window.frame)
        scrollPanel.backgroundColor = UIColor.clear
        scrollPanel.alpha = 0
        
        markPanelView = UIView(frame: scrollPanel.frame)
        markPanelView.backgroundColor = UIColor.black
        markPanelView.alpha = 0
        scrollPanel.addSubview(markPanelView)
        
        scrollView = UIScrollView(frame: scrollPanel.frame)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollPanel.addSubview(scrollView)
        
        pageLabel = UILabel()
        pageLabel.textColor = UIColor.white
        pageLabel.textAlignment = .right
        pageLabel.font = UIFont.systemFont(ofSize: 20)
        pageLabel.isHidden = true
        scrollPanel.addSubview(pageLabel)
        
        sumLabel = UILabel()
        sumLabel.textColor = UIColor.white
        sumLabel.textAlignment = .left
        sumLabel.font = UIFont.systemFont(ofSize: 20)
        sumLabel.isHidden = true
        scrollPanel.addSubview(sumLabel)
        
        moreButton = UIButton()
        moreButton.isHidden = true
        moreButton.setBackgroundImage(UIImage(named: "FavoritesListIcon"), for: UIControl.State())
        scrollPanel.addSubview(moreButton)
        
        itemWidth = scrollView.frame.size.width + CGFloat(spaceWitdh*2)
        
        
        ///未封装待定
        backMarkView = UIView()
        backMarkView.isHidden = true
        backMarkView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        backMarkView.alpha = 0.6
        backMarkView.backgroundColor = UIColor.black
        scrollPanel.addSubview(backMarkView)
        
        saveButton = UIButton()
        saveButton.isHidden = true
        saveButton.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: backMarkView.frame.width, height: 49)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        saveButton.layer.cornerRadius = 5
        saveButton.layer.masksToBounds = true
        saveButton.backgroundColor = UIColor.white
        saveButton.setTitle("保存图片", for: UIControl.State())
        saveButton.setTitleColor(UIColor.gray, for: UIControl.State())
        scrollPanel.addSubview(saveButton)
        
        cancelButton = UIButton()
        cancelButton.isHidden = true
        cancelButton.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height+56, width: backMarkView.frame.width, height: 49)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.masksToBounds = true
        cancelButton.backgroundColor = UIColor.white
        cancelButton.setTitle("取消", for: UIControl.State())
        cancelButton.setTitleColor(UIColor.gray, for: UIControl.State())
        scrollPanel.addSubview(cancelButton)
        
        titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 20, y: -20, width: UIScreen.main.bounds.size.width-40, height: 20)
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.isHidden = true
        titleLabel.textColor = UIColor.white
        titleLabel.text = "图片已保存到相册"
        scrollPanel.addSubview(titleLabel)
    }
    
    func showImages(_ imageArray: [UIImageView], index: NSInteger, count: NSInteger, urls: [String]) {
        if index < urls.count {
            ///私有方法
            self.imageViews = imageArray
            self.imageUrls = urls
            setPageControll(urls.count, index: index)
            ///获取scrollSize
            var contentSize = scrollView.frame.size
            contentSize.width = itemWidth * CGFloat(urls.count)
            contentSize.height = window.frame.size.height
            scrollView.contentSize = contentSize
            scrollView.delegate = self
            window.addSubview(scrollPanel)
            
//            print("获取到的imageView \(imageArray[index])")
            
            ///获取scrollOffset
            let currentImageView = imageArray[index]
            let convertRect = currentImageView.superview?.convert(currentImageView.frame, to: window)
            var contentOffset = scrollView.contentOffset
            contentOffset.x = itemWidth * CGFloat(index)
            scrollView.contentOffset = contentOffset
            
            //私有方法
            addSubImageView(imageArray, index: index)
            
            var frame = scrollView.bounds
            frame.origin.x = itemWidth * CGFloat(index)
            frame.origin.y = 0
            frame.size.width = itemWidth
            
            let tempImageScrollView = HCImageScrollView()
            tempImageScrollView.frame = frame.insetBy(dx: CGFloat(spaceWitdh), dy: 0)
            tempImageScrollView.setContentWithFrame(convertRect!)
            let url = urls[index]
            imageUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let image = currentImageView.image {
                tempImageScrollView.setImage(image, url: imageUrl)
            }
            
            ///代理
            tempImageScrollView.imageDelegate = self
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(3) / Double(NSEC_PER_SEC), execute: { () -> Void in
                self.setOriginFrame(tempImageScrollView)
            })
            
            scrollView.addSubview(tempImageScrollView)
            scrollView.frame = CGRect(x: CGFloat(-spaceWitdh), y: 0, width: itemWidth, height: scrollPanel.frame.size.height)
        }
    }
    
    fileprivate func setPageControll(_ numbers: NSInteger, index: NSInteger) {
        
        pageLabel.text = "\(index+1)"
        pageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        pageLabel.center = CGPoint(x: scrollPanel.center.x-50, y: scrollPanel.bounds.size.height-30)
        
        sumLabel.text = "/\(numbers)"
        sumLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        sumLabel.center = CGPoint(x: scrollPanel.center.x+50, y: scrollPanel.bounds.size.height-30)
        
//        moreButton.addTarget(self, action: #selector(HCShowImageManager.buttonAction(_:)), for: .touchUpInside)
        moreButton.frame = CGRect(x: 0, y: 0, width: 60, height: 27)
        moreButton.center = CGPoint(x: scrollPanel.bounds.size.width-30, y: scrollPanel.bounds.size.height-25)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(HCShowImageManager.buttonAction(_:)))
        longPressGesture.minimumPressDuration = 1
        scrollPanel.addGestureRecognizer(longPressGesture)
    }
    
    // MARK: **** 加载其他页面 ****
    fileprivate func addSubImageView(_ imageArray: [UIImageView], index: NSInteger) {
        (imageArray as NSArray).enumerateObjects({ (obj, idx, stop) -> Void in
            if index == idx {
                return
            }
            let tempView = imageArray[idx]
            let contentRect = tempView.superview?.convert(tempView.frame, to: nil)
            var frame = self.scrollView.bounds
            frame.origin.x = self.itemWidth * CGFloat(idx)
            frame.origin.y = 0
            frame.size.width = self.itemWidth
            
            let tempImageScrollView = HCImageScrollView()
            tempImageScrollView.frame = frame.insetBy(dx: CGFloat(self.spaceWitdh), dy: 0)
            
            ///ImageScrollView中的方法+代理
            tempImageScrollView.setContentWithFrame(contentRect!)
//                        tempImageScrollView.setImage(tempView.image!)
            if idx < self.imageViews.count && idx < self.imageUrls.count {
                let imageView = self.imageViews[idx]
                let url = self.imageUrls[idx]
                tempImageScrollView.setImage(imageView.image ?? UIImage(), url: url)
            }
            tempImageScrollView.imageDelegate = self
            self.scrollView.addSubview(tempImageScrollView)
            
            ///ImageScrollView中的方法
            tempImageScrollView.setAnimationRect()
        })
    }
    
    // MARK: **** 放大 ****
    func setOriginFrame(_ sender: HCImageScrollView) {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.scrollPanel.alpha = 1.0
            self.markPanelView.alpha = 1.0
            }, completion: { (finished) -> Void in
                UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.none)
        })
        
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            ///ImageScrollView中的方法
            sender.setAnimationRect()
            }, completion: { (finished) -> Void in
                self.pageLabel.isHidden = false
                self.sumLabel.isHidden = false
                self.moreButton.isHidden = false
        }) 
    }
    
    // MARK: **** 缩小 ****
    func tapImageViewWithObject(_ sender: AnyObject) {
        let tempImageView = sender as! HCImageScrollView
            UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.none)
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.markPanelView.alpha = 0
                self.pageLabel.isHidden = true
                self.sumLabel.isHidden = true
                self.moreButton.isHidden = true
            })
            
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                tempImageView.reChangeInitRect()
                }, completion: { (finished) -> Void in
                    self.scrollPanel.alpha = 0
                    self.scrollPanel.removeFromSuperview()
                    for tempView in self.scrollView.subviews {
                        tempView.removeFromSuperview()
                    }
            })
    }
    
    // MARK: **** ScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x/itemWidth)
        pageLabel.text = "\(currentPage+1)"
        if currentPage < self.imageUrls.count {
            imageUrl = self.imageUrls[currentPage]
        }
        for tempView in scrollView.subviews as! [HCImageScrollView] {
            if tempView.isKind(of: HCImageScrollView.self) {
                tempView.setZoomScale(1, animated: true)
            }
        }
    }
    
    // MARK: **** buttonAction ****
    @objc func buttonAction(_ sender: UILongPressGestureRecognizer) {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.backMarkView.alpha = 0.6
            self.saveButton.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height-105, width: self.backMarkView.frame.width, height: 49)
            self.cancelButton.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height-49, width: self.backMarkView.frame.width, height: 49)
            self.backMarkView.isHidden = false
            self.saveButton.isHidden = false
            self.cancelButton.isHidden = false
        }) 
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(HCShowImageManager.TapAction))
        backMarkView.addGestureRecognizer(tap)
        
        saveButton.addTarget(self, action: #selector(HCShowImageManager.buttonClick), for: .touchUpInside)
        
        cancelButton.addTarget(self, action: #selector(HCShowImageManager.cancelClick), for: .touchUpInside)
    }
    
    @objc func buttonClick() {
        if let url = URL(string: imageUrl) {
            ImageDownloader.default.downloadImage(with: url, retrieveImageTask: nil, options: nil, progressBlock: { (progress, total) in
                
            }) { (image, error, source, data) in
                if let image = image {
                    DispatchQueue.main.async {
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        self.completionAction()
                    }
                }
            }
        }
        cancelClick()
    }
    
    @objc func cancelClick() {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.saveButton.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: self.backMarkView.frame.width, height: 49)
            self.cancelButton.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height+56, width: self.backMarkView.frame.width, height: 49)
            
        }) 
        saveButton.isHidden = true
        backMarkView.alpha = 0
    }
    
    @objc func TapAction() {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.saveButton.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: self.backMarkView.frame.width, height: 49)
            self.cancelButton.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height+56, width: self.backMarkView.frame.width, height: 49)
            
        }) 
        saveButton.isHidden = true
        backMarkView.alpha = 0
    }
    
    func completionAction() {
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.titleLabel.frame = CGRect(x: 20, y: 20, width: UIScreen.main.bounds.size.width-40, height: 20)
            self.titleLabel.isHidden = false
            }, completion: { (finished) -> Void in
                UIView.animate(withDuration: 1, animations: { () -> Void in
                    self.titleLabel.frame = CGRect(x: 20, y: -20, width: UIScreen.main.bounds.size.width-40, height: 20)
                    self.titleLabel.isHidden = true
                })
        })
    }
}









