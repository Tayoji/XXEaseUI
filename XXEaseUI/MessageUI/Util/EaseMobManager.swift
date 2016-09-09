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
public class EaseMobManager:NSObject,EMChatManagerDelegate,EMClientDelegate{
    public static let instance = EaseMobManager()
    
    var unreadMessagesCount:Int32 = 0
    
    private override init(){
    }
    func configEaseMob(application:UIApplication,launchOptions:[NSObject: AnyObject]?){
      EaseSDKHelper.shareHelper().easemobApplication(application, didFinishLaunchingWithOptions: launchOptions, appkey: AppKey, apnsCertName: apnsCertName, otherConfig: [kSDKConfigEnableConsoleLogger:true])
        EMClient.sharedClient().chatManager.addDelegate(self, delegateQueue: nil)
        EMClient.sharedClient().addDelegate(self, delegateQueue: nil)
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
        return EMClient.sharedClient().isLoggedIn
    }
    func logout(block:((error:EMError?) -> Void)?){
        let error =  EMClient.sharedClient().logout(true)
        if (block != nil) {
            block!(error: error)
        }
    }
    // 未读消息
    func unreadMessageCount() ->Int32{
        var count:Int32 = 0
        let conversations = EMClient.sharedClient().chatManager.getAllConversations() as! [EMConversation]
        for con in conversations {
          count += con.unreadMessagesCount
        }
        return count
    }
    // 接受消息
    public func didReceiveMessages(aMessages: [AnyObject]!) {
        
        NSNotificationCenter.defaultCenter().postNotificationName(UpdateMessage, object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName(UpdateMessageCount, object: nil)
        if !aMessages.isEmpty{
            if let message = aMessages.last as? EMMessage{
                PromptManager.instance.play(message)
            }
        }

        
    }
    
    
    func showlocalNotification(message:EMMessage){
        let localNotification = UILocalNotification.init()
        localNotification.fireDate = NSDate()
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertLaunchImage = "AppIcon"
         let con = EMClient.sharedClient().chatManager.getConversation(message.conversationId, type: EMConversationTypeChat, createIfNotExist: false)
        if con.isNotice() {
        
        }else{
            
        }
        if #available(iOS 8.2, *) {
            localNotification.alertTitle = con.nickname
        } else {
            // Fallback on earlier versions
        }
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.alertBody = con.lastMessageText
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    func rx_unreadMessagesCount(count:Int){
        
    }
    //异地登陆
    public func didLoginFromOtherDevice() {
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