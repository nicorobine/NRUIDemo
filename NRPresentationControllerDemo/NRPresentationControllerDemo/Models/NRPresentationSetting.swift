//
//  NRPresentationSetting.swift
//  NRPresentationControllerDemo
//
//  Created by NicoRobine on 2020/11/27.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

import UIKit

class NRPresentationSetting: NSObject {
    
    static var shared: NRPresentationSetting {
        return Inner.instance
    }
    
    struct Inner {
        static let instance = NRPresentationSetting()
    }
    
    /// 是否使用自定义动画
    var useCustomAnimation = false
    
    /// 模态展示样式
    var presentationStyle = UIModalPresentationStyle.automatic;
}
