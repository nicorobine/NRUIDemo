//
//  NRCellProtocol.swift
//  NRPresentationControllerDemo
//
//  Created by 王文涛 on 2020/11/28.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

import UIKit

protocol NRCellProtocol {
    associatedtype CellItem
    
    /// 当前的索引
    var index: Int { set get }
    
    /// 所属的section
    var section: Int { set get }
    
    var item: CellItem { set get }
    
}

protocol NRCellInteractionProtocol {
    associatedtype CellItem
    
    /// cell点击
    func onTapCell(section: Int, index: Int, item: CellItem) -> Void
}

protocol NRCellSelectedProtocol {
    
    associatedtype CellItem
    
    /// 选中状态
    var selected: Bool { set get }
    
    /// 将要选中
    func willSelect(in section: Int, at index: Int, of item: CellItem) -> Bool
    
    /// 已经选中
    func DidSelect(in section: Int, at index: Int, of item: CellItem) -> Bool
    
    /// 将要取消选中
    func willDeselect(in section: Int, at index: Int, of item: CellItem) -> Bool
    
    /// 已经取消选中
    func didDeselect(in section: Int, at index: Int, of item: CellItem) -> Bool
    
    /// cell高亮状态改变
    func onHighlightStateChange(section: Int, index: Int, item: CellItem, highlight: Bool) -> Void
}

protocol NRCellHighlightProtocol {
    associatedtype CellItem
    
    /// 高亮状态
    var hightlighted: Bool { set get }
    
    /// 将要高亮
    func willHighlight(in section: Int, at index: Int, of item: CellItem) -> Bool
    
    /// 已经高亮
    func didHighlight(in section: Int, at index: Int, of item: CellItem) -> Bool
    
    /// 将要取消高亮
    func willUnhightlight(in section: Int, at index: Int, of item: CellItem) -> Bool
    
    /// 已经取消高亮
    func didUnhightlight(in section: Int, at index: Int, of item: CellItem) -> Bool
}
