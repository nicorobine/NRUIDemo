//
//  NRPresentationBaseTableViewCell.swift
//  NRPresentationControllerDemo
//
//  Created by 王文涛 on 2020/12/1.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

import UIKit

class NRPresentationBaseTableViewCell: NRBaseTableViewCell<NRPresentationBoolSetting> {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryView = UISwitch()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
