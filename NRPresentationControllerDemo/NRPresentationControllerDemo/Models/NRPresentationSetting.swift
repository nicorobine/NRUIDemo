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

extension NRPresentationSetting: NRCollectionModelProtocol {
    
    
    
    typealias Section = NRSettingSection
    
    var children: Array<NRSettingSection> {
        get {
            return Array.init(arrayLiteral: NRSettingSection())
        }
        set {
        }
    }
    
    var grouped: Bool {
        return false
    }
    
    func nr_section(at index: Int) -> NRSettingSection {
        return children[index]
    }
    
    func nr_cell<T>(in section: Int, at index: Int) -> T {
        return nr_section(at: section).items[index] as! T
    }
}

class NRSettingSection: NRSectionBase<NRSettingCell> {
    
}

class NRSettingCell: NRCellBase<NRSetting> {
    
}

class NRSetting {
    let title: String
    
    init(title: String) {
        self.title = title;
    }
}
