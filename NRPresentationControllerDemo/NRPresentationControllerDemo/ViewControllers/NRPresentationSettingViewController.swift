//
//  NRPresentationSettingViewController.swift
//  NRPresentationControllerDemo
//
//  Created by NicoRobine on 2020/11/27.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

import UIKit

class NRPresentationSettingViewController: UITableViewController {
        
    let setting: NRPresentationSetting
    
    init(_ setting: NRPresentationSetting = NRPresentationSetting()) {
        self.setting = setting
        super.init(style: .grouped)
        title = .title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nr_initialUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - UI
    func nr_initialUI() -> Void {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: .settingCellIdentifier);
        tableView.bounces = true
        tableView.isScrollEnabled = true
        tableView.allowsMultipleSelection = false
    }
}

// tableView
extension NRPresentationSettingViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return setting.children.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setting.children[section].items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .settingCellIdentifier, for: indexPath)
        let settingItem = setting.children[indexPath.section].items[indexPath.row]
        cell.textLabel?.text = settingItem.item.title
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byTruncatingHead
        cell.accessoryType = settingItem.accessoryType
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.selectionStyle = settingItem.selectionStyle
        if settingItem.selected {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return setting.children[section].title
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingItem = setting.children[indexPath.section].items[indexPath.row];
        settingItem.DidSelect(in: indexPath.section, at: indexPath.row, of: settingItem.item)
        tableView.cellForRow(at: indexPath)?.accessoryType = settingItem.accessoryType
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let settingItem = setting.children[indexPath.section].items[indexPath.row];
        settingItem.didDeselect(in: indexPath.section, at: indexPath.row, of: settingItem.item)
        tableView.cellForRow(at: indexPath)?.accessoryType = settingItem.accessoryType
    }
}


fileprivate extension String {
    static let settingCellIdentifier: String = "cellId"
    
    static let title: String = NSLocalizedString("设置", comment: "设置展示的样式")
}


