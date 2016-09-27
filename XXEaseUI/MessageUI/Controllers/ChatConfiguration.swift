//
//  ChatConfiguration.swift
//  supplier
//
//  Created by xiucheren on 16/7/27.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

import Foundation
import UIKit
extension EaseChatListController:UITableViewDelegate{

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        if isNotices{
//            let vc = mainSB.instantiateViewControllerWithIdentifier("MessageDetailController") as! MessageDetailController
//            vc.conversationModel = conversations[indexPath.row]
//            vc.hidesBottomBarWhenPushed = true
//            navigationController?.pushViewController(vc, animated: true)
//            
//        }else{
//            
//            let chatController =  EaseChatDetailsController.init(conversationChatter: conversations[indexPath.row].conversationId, nickname: conversations[indexPath.row].nickname, avatar: conversations[indexPath.row].avatar, ownNickname: userInfo!.imNickname, ownAvatar: userInfo!.imAvatar)
//            chatController.hidesBottomBarWhenPushed = true
//            navigationController?.pushViewController(chatController, animated: true)
//        }
        
    }
}

let SelectTabBarIndex = "SelectTabBarIndex"
extension EaseChatDetailsController{
    
    func configurationView(){
        self.setRightItem()
    }
    func setRightItem(){
        self.setRightItemImage(UIImage(named: "EaseUIResource.bundle/moreMenu/more_icon"), select: UIImage(named: "EaseUIResource.bundle/moreMenu/more-xiaoxi_icon")) {
            if self.moreMenuView == nil {
                self.moreMenuView = MoreMenuView.showMoreMenuView(self.view, block: { (index) in
                    self.jumpVc(index)
                })
            }else{
               self.disMissMoreMenuView()
            }
        }
    }
    func jumpVc(_ index:Int){
        disMissMoreMenuView()
        switch index {
        case 0:
            self.jumpMainVc()
            break
        case 1:
            self.jumpMessageVc()
            break
        default:
            break
        }
    }
    func jumpMessageVc(){
//        if let index = self.tabBarController?.selectedIndex{
//            self.navigationController?.popToRootViewControllerAnimated(false)
//
//            if index != 1 {
//                tabBarVc?.selectedIndex = 1
//
//
//            }
//        }
    }
    func jumpMainVc(){
//        if let index = self.tabBarController?.selectedIndex{
//            self.navigationController?.popToRootViewControllerAnimated(false)
//            if index != 0 {
//                tabBarVc?.selectedIndex = 0
////                tabBarVc?.tabBar.hidden = false
//            }
//        }
    }
    
    func disMissMoreMenuView(){
        var frame = self.moreMenuView!.backImageView.frame
        frame.origin.y = -96
        UIView.animate(withDuration: 0.5, animations: {
            self.moreMenuView?.backImageView.frame = frame
            }, completion: { (com) in
                if com {
                    self.moreMenuView?.removeFromSuperview()
                    self.moreMenuView = nil
                }
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: Notification.Name(rawValue: UpdateMessageCount), object: nil)
        
    }
}
