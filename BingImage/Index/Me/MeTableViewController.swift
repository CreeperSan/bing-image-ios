//
//  IndexMeTableViewController.swift
//  BingImage
//
//  Created by creepersan on 2020/1/20.
//  Copyright © 2020 creepersan. All rights reserved.
//

import UIKit

enum MeTableViewHeaderID : Int8{
    case Undefine = 0
    case Gallery = 1
    case Setting = 2
    case Website = 3
    case Feedback = 4
    case Help = 5
    case About = 6
}

class MeTableViewController: UITableViewController {
    
    private final let items : Array<Array<MeListItem>> = [
        [
            MeListItem.init(id: MeTableViewHeaderID.Gallery, name: "我的下载", icon: "", nav: MeListItem.NAV_ARROW)
        ],[
            MeListItem.init(id: MeTableViewHeaderID.Setting, name: "设置", icon: "", nav: MeListItem.NAV_ARROW)
        ],[
            MeListItem.init(id: MeTableViewHeaderID.Website, name: "访问网页版", icon: "", nav: MeListItem.NAV_EXTERNAL),
            MeListItem.init(id: MeTableViewHeaderID.Feedback, name: "反馈", icon: "", nav: MeListItem.NAV_NONE)
        ],[
            MeListItem.init(id: MeTableViewHeaderID.Help, name: "帮助", icon: "", nav: MeListItem.NAV_ARROW),
            MeListItem.init(id: MeTableViewHeaderID.About, name: "关于", icon: "", nav: MeListItem.NAV_ARROW)
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = MeHeaderView.headerView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = v
        tableView.sectionHeaderHeight = 6
        tableView.sectionHeaderHeight = 0
        
        // 初始化NavigationBarButton
        let backBarButton = UIBarButtonItem.init()
        backBarButton.title = "返回"
        self.navigationItem.backBarButtonItem = backBarButton
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        let item = items[indexPath.section][indexPath.row]
        // 标题
        cell.textLabel?.text = item.name
        // 导航图标
        switch item.nav{
            case MeListItem.NAV_NONE:
                cell.accessoryType = UITableViewCell.AccessoryType.none
                break
            case MeListItem.NAV_ARROW:
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                break
            case MeListItem.NAV_EXTERNAL:
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                break
            default:
                break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section][indexPath.row]
        switch item.id {
            case MeTableViewHeaderID.Gallery:
                break
            case MeTableViewHeaderID.Setting:
                break
            case MeTableViewHeaderID.Website:
                UIApplication.shared.open(URL.init(string: "http://bing.creepersan.com")!)
                
//                let webSiteController = WebSiteViewController.init()
//                self.navigationController?.pushViewController(webSiteController, animated: true)
                break
            case MeTableViewHeaderID.Feedback:
                break
            case MeTableViewHeaderID.Help:
                let helpController = HelpViewController.init()
                self.navigationController?.pushViewController(helpController, animated: true)
                break
            case MeTableViewHeaderID.About:
                let aboutController = AboutViewController.init()
                self.navigationController?.pushViewController(aboutController, animated: true)
                break
            default:
                break
        }
        // 取消高亮
        tableView.deselectRow(at: indexPath, animated: true)
    }


}
