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

    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 72.0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
        self.setRightItemImage(UIImage(named: "EaseUIResource.bundle/moreMenu/more_icon"), selectImage: UIImage(named: "EaseUIResource.bundle/moreMenu/more-xiaoxi_icon")) {
            if self.moreMenuView == nil {
                self.moreMenuView = MoreMenuView.showMoreMenuView(self.view, block: { (index) in
                    self.jumpVc(index)
                })
            }else{
               self.disMissMoreMenuView()
            }
        }
    }
    func jumpVc(index:Int){
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
        UIView.animateWithDuration(0.5, animations: {
            self.moreMenuView?.backImageView.frame = frame
            }, completion: { (com) in
                if com {
                    self.moreMenuView?.removeFromSuperview()
                    self.moreMenuView = nil
                }
        })
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName(UpdateMessageCount, object: nil)
        
    }
}
