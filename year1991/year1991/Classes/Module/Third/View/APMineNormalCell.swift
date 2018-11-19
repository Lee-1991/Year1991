//
//  APMineNormalCell.swift
//  ActiveProject
//
//  Created by Lee on 2018/8/14.
//  Copyright © 2018年 7moor. All rights reserved.
//
//  个人中心-普通cell

import UIKit

class APMineNormalCell: UITableViewCell {
    
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
        
        backgroundColor = UIColor.color("#FFFFFF")
        
        addSubview(titltLbl)
        addSubview(arrowIcon)
        addSubview(infoLbl)
        addSubview(separateLine)
        
        titltLbl.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(15)
        }
        
        arrowIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-15)
        }
        
        infoLbl.snp.makeConstraints { (make) in
            make.centerY.equalTo(titltLbl)
            make.right.equalTo(-15)
        }
        
        separateLine.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    fileprivate lazy var titltLbl: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.color("#444E53")
        label.font = UIFont.font(17)
        return label
    }()
    
    private lazy var arrowIcon: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var infoLbl: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.color("#B3B3B3")
        label.font = UIFont.font(17)
        label.textAlignment = .right
        label.isHidden = true
        return label
    }()
    
    fileprivate var separateLine: UIView = {
        let view = UIView.initSeparateLine()
        return view
    }()

}

extension APMineNormalCell {
    
    class func heightOfCell() -> CGFloat {
        return 50
    }
    
    func setData(_ viewModel: APMineNormalCellViewModel) {
        titltLbl.text = viewModel.title
        
        if let info = viewModel.info {
            arrowIcon.isHidden = true
            infoLbl.isHidden = false
            infoLbl.text = info
        } else {
            infoLbl.isHidden = true
            arrowIcon.isHidden = false
        }
    }
}
