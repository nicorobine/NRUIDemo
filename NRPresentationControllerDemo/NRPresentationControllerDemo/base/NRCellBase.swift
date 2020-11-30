//
//  NRCellBase.swift
//  NRPresentationControllerDemo
//
//  Created by 王文涛 on 2020/11/28.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

import UIKit

class NRCellBase<Item>: NRCellProtocol, NRCellInteractionProtocol {
    
    
    typealias CellItem = Item
    
    var item: Item
    
    var index: Int = 0
    
    var section: Int = 0
    
    var accessoryType: UITableViewCell.AccessoryType = .none
    
    var selectionStyle: UITableViewCell.SelectionStyle = .none
    
    func onTapCell(section: Int, index: Int, item: Item) {
        
    }
    
    init(item: Item) {
        self.item = item
    }
}

class NRSectionBase<T : NRCellProtocol>: NRSectionProtocol {
    
    typealias Cell = T
    
    /// 分组索引
    var section: Int = 0
    
    /// 分组名字
    var title: String?
    
    /// 子项目
    var items: Array<Cell> = []
    
    init() {}
}
