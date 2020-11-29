//
//  NRCollectionModelProtocol.swift
//  NRPresentationControllerDemo
//
//  Created by 王文涛 on 2020/11/28.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

import Foundation

protocol NRCollectionModelProtocol {
    
    associatedtype Section : NRSectionProtocol
    
    /// 分组项目
    var children: Array<Section> { set get };
    
    /// 是否分组显示
    var grouped: Bool { get }
    
    /// 根据索引返回section
    func nr_section(at index: Int) -> Section;
    
    /// 根据section和cell的索引获取cell
    func nr_cell<T: NRCellProtocol>(in section: Int, at index: Int) -> T
}
