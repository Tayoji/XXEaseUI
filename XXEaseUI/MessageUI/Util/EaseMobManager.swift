//
//  EaseMobManager.swift
//  supplier
//
//  Created by xiucheren on 16/3/30.
//  Copyright © 2016年 xiucheren. All rights reserved.
//

import UIKit



let isDev = true
let AppKey = isDev ? "xiucheren#supplier" : "xiucheren#xiucheren"
let apnsCertName = isDev ? "supplier" : "supplier"
let UpdateMessage = "UpdateMessage"
let UpdateMessageCount = "UpdateMessageCount"


let NoDisturbStatus = "NoDisturbStatus"
let NotificationJumpMessage = "NotificationJumpMessage"
open class EaseMobManager:NSObject,EMChatManagerDelegate,EMClientDelegate{
    open static let instance = EaseMobManager()
    
    var unreadMessagesCount:Int32 = 0
    
    fileprivate override init(){
    }
    func configEaseMob(_ application:UIApplication,launchOptions:[AnyHashable: Any]?){
      EaseSDKHelper.share().easemobApplication(application, didFinishLaunchingWithOptions: launchOptions, appkey: AppKey, apnsCertName: apnsCertName, otherConfig: [kSDKConfigEnableConsoleLogger:true])
        EMClient.shared().chatManager.add(self, delegateQueue: nil)
        EMClient.shared().add(self, delegateQueue: nil)
    }

    func login(){
//        if userInfo != nil {
//            let userName = OCUtils.lowermd5("SP_" + (userInfo?.loginName)!)
//            EMClient.sharedClient().asyncLoginWithUsername(userName, password: userName, success: {
//                EMClient.sharedClient().asyncGetPushOptionsFromServer({ (options) in
//                    NSUserDefaults.standardUserDefaults().setBool(options.noDisturbStatus != EMPushNoDisturbStatusClose, forKey: NoDisturbStatus)
//
//                    }, failure: { (error) in
//                        
//                })
//                }, failure: { (error) in
//                    
//            })
//   
//        }
    }
    
    
    func isLoggedIn() -> Bool {
        return EMClient.shared().isLoggedIn
    }
    func logout(_ block:((_ error:EMError?) -> Void)?){
        let error =  EMClient.shared().logout(true)
        if (block != nil) {
            block!(error)
        }
    }
    // 未读消息
    func unreadMessageCount() ->Int32{
        var count:Int32 = 0
        let conversations = EMClient.shared().chatManager.getAllConversations() as! [EMConversation]
        for con in conversations {
          count += con.unreadMessagesCount
        }
        return count
    }
    // 接受消息
    open func didReceiveMessages(_ aMessages: [AnyObject]!) {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: UpdateMessage), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: UpdateMessageCount), object: nil)
        if !aMessages.isEmpty{
            if let message = aMessages.last as? EMMessage{
                PromptManager.instance.play(message)
            }
        }

        
    }
    
    
    func showlocalNotification(_ message:EMMessage){
        let localNotification = UILocalNotification.init()
        localNotification.fireDate = Date()
        localNotification.timeZone = TimeZone.current
        localNotification.alertLaunchImage = "AppIcon"
         let con = EMClient.shared().chatManager.getConversation(message.conversationId, type: EMConversationTypeChat, createIfNotExist: false)
        if (con?.isNotice())! {
        
        }else{
            
        }
        if #available(iOS 8.2, *) {
            localNotification.alertTitle = con?.nickname
        } else {
            // Fallback on earlier versions
        }
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.alertBody = con?.lastMessageText
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    func rx_unreadMessagesCount(_ count:Int){
        
    }
    //异地登陆
    open func didLoginFromOtherDevice() {
//            MBProgressHUD.MB_ShowMessage(keyWindow, message: "账号在其它设备登录,请重新登录").completion({
//            UserModel.removeUserInfo()
//            let vc = mainSB.instantiateViewControllerWithIdentifier("loginNavigationController")
//            ToolKit.getCurVc()?.presentViewController(vc, animated: true, completion: nil)
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//                EMClient.sharedClient().logout(true)
//            }
//        })
    }
    
    
    
}
