//
//  NRSectionProtocol.swift
//  NRPresentationControllerDemo
//
//  Created by 王文涛 on 2020/11/28.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

import UIKit

protocol NRSectionProtocol {
    
    associatedtype Cell : NRCellProtocol
    
    /// 分组索引
    var section: Int { get set }
    
    /// 分组名字
    var title: String? { get set }
    
    /// 子项目
    var items: Array<Cell> { get set }
}

