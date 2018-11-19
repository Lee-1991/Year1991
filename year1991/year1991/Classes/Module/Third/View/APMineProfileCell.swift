//
//  APMineProfileCell.swift
//  ActiveProject
//
//  Created by Lee on 2018/8/14.
//  Copyright © 2018年 7moor. All rights reserved.
//
//  个人中心-个人信息

import UIKit

class APMineProfileCell: UITableViewCell {

    private lazy var topBackView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: -300, width: kScreenWidth, height: 400)
        view.backgroundColor = UIColor.color(r: 238, g: 146, b: 55)
        return view
    }()
    
    lazy var backImgView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "mine_profile_background"))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.color("#FFFFFF")
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    fileprivate lazy var headIcon: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.color("#4A4A4A")
        view.layer.cornerRadius = 40
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
//        let url = URL.init(string: APAppEngin.shared.user?.protrail ?? "")
//        view.kf.setImage(with: url)
        return view
    }()
    
    fileprivate lazy var nickLbl: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.color("#444E53")
        label.font = UIFont.mediumFont(20)
//        label.text = APAppEngin.shared.user?.nick
        return label
    }()
    
    private lazy var seperateLine: UIView = {
        let view = UIView.initSeparateLine()
        return view
    }()
    
    private lazy var groupLbl: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.color("#617892")
        label.font = UIFont.font(16)
        label.text = "创建活动"
        return label
    }()
    
    fileprivate lazy var groupInfoLbl: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.color("#444E53")
        label.font = UIFont.mediumFont(20)
        label.text = "60"
        return label
    }()
    
    private lazy var hotLbl: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.color("#617892")
        label.font = UIFont.font(16)
        label.text = "照片总数"
        return label
    }()
    
    fileprivate lazy var hotInfoLbl: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.color("#444E53")
        label.font = UIFont.mediumFont(20)
        label.text = "10w+"
        return label
    }()
    
    private lazy var albumLbl: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.color("#617892")
        label.font = UIFont.font(16)
        label.text = "活动相册"
        return label
    }()
    
    fileprivate lazy var albumInfoLbl: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.color("#444E53")
        label.font = UIFont.mediumFont(20)
        label.text = "27"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setupUI() {
        backgroundColor = UIColor.color("#F5F5F9")
        selectionStyle = .none
        
        addSubview(topBackView)
        addSubview(backImgView)
        addSubview(infoView)
        addSubview(headIcon)
        addSubview(nickLbl)
        addSubview(seperateLine)
        addSubview(groupLbl)
        addSubview(groupInfoLbl)
        addSubview(hotLbl)
        addSubview(hotInfoLbl)
        addSubview(albumLbl)
        addSubview(albumInfoLbl)
        
        infoView.snp.makeConstraints { (make) in
            make.left.equalTo(kMargin)
            make.bottom.equalToSuperview()
            make.right.equalTo(-kMargin)
            make.height.equalTo(200)
        }
        
        backImgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(infoView.snp.top).offset(38)
        }
        
        headIcon.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(infoView.snp.top)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        nickLbl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(headIcon.snp.bottom).offset(16)
        }
        
        seperateLine.snp.makeConstraints { (make) in
            make.left.equalTo(infoView)
            make.right.equalTo(infoView)
            make.top.equalTo(nickLbl.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        
        groupLbl.snp.makeConstraints { (make) in
            make.left.equalTo(topBackView).offset(55)
            make.top.equalTo(seperateLine.snp.bottom).offset(17)
        }
        
        groupInfoLbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(groupLbl)
            make.top.equalTo(groupLbl.snp.bottom).offset(15)
        }
        
        hotLbl.snp.makeConstraints { (make) in
            make.centerY.equalTo(groupLbl)
            make.centerX.equalToSuperview()
        }
        
        hotInfoLbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(hotLbl)
            make.centerY.equalTo(groupInfoLbl)
        }
        
        albumLbl.snp.makeConstraints { (make) in
            make.centerY.equalTo(groupLbl)
            make.right.equalTo(infoView).offset(-36)
        }
        
        albumInfoLbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(albumLbl)
            make.centerY.equalTo(groupInfoLbl)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension APMineProfileCell {
    
    class func heightOfCell() -> CGFloat {
        return 280
    }
}
