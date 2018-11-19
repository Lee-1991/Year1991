//
//  APMineViewModel.swift
//  ActiveProject
//
//  Created by Lee on 2018/8/16.
//  Copyright © 2018年 7moor. All rights reserved.
//

import UIKit

struct APMineViewModel {
    
    let setctionCount = 2
    
    lazy var settingDatas: [APMineNormalCellViewModel] = {
        var mine = [APMineNormalCellViewModel]()
        mine.append(APMineNormalCellViewModel("设置"))
        return mine
    }()

}


struct APSettingViewModel {
    
    let setctionCount = 1
    
    lazy var settingDatas: [APMineNormalCellViewModel] = {
        var mine = [APMineNormalCellViewModel]()
        mine.append(APMineNormalCellViewModel("关于活动相册",info:"V1.1"))
        mine.append(APMineNormalCellViewModel("退出"))
        return mine
    }()
    
}

struct APMineNormalCellViewModel {
    
    var title: String?
    var info: String?
    
    init(_ title: String, info: String? = nil) {
        self.title = title
        self.info = info
    }
}
