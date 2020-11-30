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
    
    var modalPresentionStyle: UIModalPresentationStyle {

        if let setting = _children.first?.items.filter({ (item: NRSettingItem) -> Bool in
        return item.selected
        }).first?.item {
            if let pSetting = (setting as? NRModalPresentationStyleSetting) {
                return pSetting.modalPresentationStyle
            }
        }
        
        return UIModalPresentationStyle.fullScreen
    }
    
    
    private var _children: Array<NRSettingSection>;
    
    override init() {
        _children = Array()
        super.init()
        _children.append(NRSettingSection(title: .presentationStyleSectionTitle, section: 0, children: modalPresentationStyles()))
        _children.first?.items.first?.selected = true
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
            return _children
        }
        set {
            _children = newValue
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

fileprivate extension NRPresentationSetting {
    
    func modalPresentationStyles() -> Array<NRSettingItem> {
        var styles = Array<NRSettingItem>()
        
        for style in 0...9 {
            var index = style
            if index == 8 {
                index = -1;
            } else if style == 9 {
                index = -2
            }
            if let style = UIModalPresentationStyle.init(rawValue: index) {
                styles.append(NRSettingItem(item: NRModalPresentationStyleSetting(title: nr_getNameOfModalStyle(style: style), modalPresentationStyle: style)));
            }
        }
        return styles
    }
    
    func nr_getNameOfModalStyle(style: UIModalPresentationStyle) -> String {
        return String.presentationStyleTitleMap[style] ?? "UIModalPresentationStyle.fullScreen";
    }
}

class NRSettingSection: NRSectionBase<NRSettingItem> {
    init(title: String?, section: Int, children: Array<NRSettingItem>) {
        super.init()
        self.title = title
        self.section = section;
        self.items = children;
    }
}

class NRSettingItem: NRCellBase<NRSetting>, NRCellSelectedProtocol {
    var selected: Bool {
        didSet {
            accessoryType = selected ? .checkmark : .none
        }
    }
    
    init(item: NRSetting, selected: Bool = false) {
        self.selected = selected
        super.init(item: item)
    }
    
    func willSelect(in section: Int, at index: Int, of item: NRSetting) -> Bool {
        return true
    }
    
    func DidSelect(in section: Int, at index: Int, of item: NRSetting) {
        selected = true
    }
    
    func willDeselect(in section: Int, at index: Int, of item: NRSetting) -> Bool {
        return true
    }
    
    func didDeselect(in section: Int, at index: Int, of item: NRSetting) {
        selected = false
    }
}

class NRSetting {
    let title: String
    
    init(title: String) {
        self.title = title;
    }
}

class NRModalPresentationStyleSetting: NRSetting {
    let modalPresentationStyle: UIModalPresentationStyle
    
    init(title: String, modalPresentationStyle: UIModalPresentationStyle) {
        self.modalPresentationStyle = modalPresentationStyle
        super.init(title: title)
    }
}


private extension String {
    static let presentationStyleSectionTitle = NSLocalizedString("呈现类型", comment: "呈现试图控制的呈现类型")
    
    static let presentationStyleTitleMap: [UIModalPresentationStyle: String] = Dictionary(dictionaryLiteral:(UIModalPresentationStyle.fullScreen, "UIModalPresentationStyle.fullScreen"),(UIModalPresentationStyle.pageSheet, "UIModalPresentationStyle.pageSheet"),(UIModalPresentationStyle.formSheet, "UIModalPresentationStyle.formSheet"),(UIModalPresentationStyle.currentContext, "UIModalPresentationStyle.currentContext"),(UIModalPresentationStyle.custom, "UIModalPresentationStyle.custom"),(UIModalPresentationStyle.overFullScreen, "UIModalPresentationStyle.overFullScreen"),(UIModalPresentationStyle.overCurrentContext, "UIModalPresentationStyle.overCurrentContext"),(UIModalPresentationStyle.popover, "UIModalPresentationStyle.popover"),(UIModalPresentationStyle.none, "UIModalPresentationStyle.none"),(UIModalPresentationStyle.automatic, "UIModalPresentationStyle.automatic"))
}
