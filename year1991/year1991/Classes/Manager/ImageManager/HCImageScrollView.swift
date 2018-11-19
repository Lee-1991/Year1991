//
//  ImageScrollView.swift
//  HCShowImage
//
//  Created by HCF on 15/12/30.
//  Copyright © 2015年 HCF. All rights reserved.
//

import UIKit

protocol HCImageScrollViewDelegate {
    func tapImageViewWithObject(_ sender: AnyObject)
}

/**
 图片消息组 
 
 目前只显示单张
 */
class HCImageScrollView: UIScrollView, UIScrollViewDelegate {
    
    ///图片
    var imageView: UIImageView!
    ///图片大小
    var imageSize: CGSize!
    ///记录自己位置
    var scaleOriginRect: CGRect = CGRect.zero
    ///记录原始位置
    var initRect: CGRect!
    
    var imageDelegate: HCImageScrollViewDelegate?

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        bouncesZoom = true
        backgroundColor = UIColor.clear
        delegate = self
        ///缩放倍数
        minimumZoomScale = 1.0
        maximumZoomScale = 2.0
        
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        addSubview(imageView)
        
        ///手势
        ///点击一次
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(HCImageScrollView.singleTapGesture(_:)))
        singleTapGesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(singleTapGesture)
        
        ///点击两次
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(HCImageScrollView.doubleTapGesture(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTapGesture)
        
        singleTapGesture.require(toFail: doubleTapGesture)
    }
    
    // MARK: **** 设置ScrollView的尺寸 ****
    func setContentWithFrame(_ rect: CGRect) {
        imageView.frame = rect
        initRect = rect
    }
    
    // MARK: **** 设置动画尺寸 ****
    func setAnimationRect() {
        imageView.frame = scaleOriginRect
    }
    
    // MARK: **** 变回原来尺寸 ****
    func reChangeInitRect() {
        zoomScale = 1.0
        imageView.frame = initRect
    }
    
    // MARK: **** 设置图片 ****
    func setImage(_ image: UIImage, url: String) {
        imageView.kf.setImage(with: URL.init(string: url), placeholder: image)
        imageSize = image.size

        ///判断缩放值
        let scaleX = frame.size.width/imageSize.width
        let scaleY = frame.size.height/imageSize.height

        if scaleX > scaleY {
            let imageViewWidth = imageSize.width * scaleY
            maximumZoomScale = frame.size.width/imageViewWidth+1
            scaleOriginRect = CGRect(x: frame.size.width/2-imageViewWidth/2, y: 0, width: imageViewWidth, height: frame.size.height)
        }else {
            let imageViewHeight = imageSize.height * scaleX
            maximumZoomScale = frame.size.height/imageViewHeight+1
            scaleOriginRect = CGRect(x: 0, y: frame.size.height/2-imageViewHeight/2, width: frame.size.width, height: imageViewHeight)
        }
    }

    // MARK: **** ScrollViewDelegate **** 
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let boundSize = scrollView.bounds.size
        let imageFrame = imageView.frame
        let contentSize = scrollView.contentSize
        var centerPoint = CGPoint(x: contentSize.width/2, y: contentSize.height/2)
        
        /// center Horizontally
        if imageFrame.size.width <= boundSize.width {
            centerPoint.x = boundSize.width/2
        }
        
        /// center Vertically
        if imageFrame.size.height <= boundSize.height {
            centerPoint.y = boundSize.height/2
        }
        
        imageView.center = centerPoint
    }
    
    @objc func singleTapGesture(_ gesture: UITapGestureRecognizer) {
        imageDelegate?.tapImageViewWithObject(self)
    }
    
    @objc func doubleTapGesture(_ gesture: UITapGestureRecognizer) {
        if self.zoomScale != 1 {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.setZoomScale(1, animated: true)
            })
        }else {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.setZoomScale(2, animated: true)
                
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
