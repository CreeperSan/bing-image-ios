//
//  IndexMeTableViewController.swift
//  BingImage
//
//  Created by creepersan on 2020/1/20.
//  Copyright © 2020 creepersan. All rights reserved.
//

import UIKit
import MessageUI

enum MeTableViewHeaderID : Int8{
    case Undefine = 0
    case Gallery = 1
    case Setting = 2
    case Website = 3
    case Feedback = 4
    case Help = 5
    case About = 6
}

class MeTableViewController: UITableViewController,MFMailComposeViewControllerDelegate{
    
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
                break
            case MeTableViewHeaderID.Feedback:
                //0.首先判断设备是否能发送邮件
                if MFMailComposeViewController.canSendMail() {
                    //1.配置邮件窗口
                    let mailView = configuredMailComposeViewController()
                    //2. 显示邮件窗口
                    present(mailView, animated: true, completion: nil)
                } else {
                    showSendMailErrorAlert()
                }
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

    func configuredMailComposeViewController() -> MFMailComposeViewController {

        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self

        //设置邮件地址、主题及正文
        mailComposeVC.setToRecipients(["admin@creepersan.com"])
        mailComposeVC.setSubject("iOS BingImage 反馈:请在这里输入问题")
        mailComposeVC.setMessageBody("问题描述:<br><br><br> 操作步骤:<br><br><br> 问题引起后果:<br>", isHTML: true)

        return mailComposeVC
    }
    
    func showSendMailErrorAlert() {

        let sendMailErrorAlert = UIAlertController(title: "未开启邮件功能", message: "设备邮件功能尚未开启，请在设置中更改", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "确定", style: .default) { _ in })
        self.present(sendMailErrorAlert, animated: true){}
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue{
        case MFMailComposeResult.sent.rawValue:
            print("邮件已发送")
        case MFMailComposeResult.cancelled.rawValue:
            print("邮件已取消")
        case MFMailComposeResult.saved.rawValue:
            print("邮件已保存")
        case MFMailComposeResult.failed.rawValue:
            print("邮件发送失败")
        default:
            print("邮件没有发送")
            break
        }

        controller.dismiss(animated: true, completion: nil)
    }
}
