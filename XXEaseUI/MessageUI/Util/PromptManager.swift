//
//  PromptManager.swift
//  supplier
//
//  Created by xiucheren on 16/8/4.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

import UIKit

class PromptManager: NSObject {
    //震动状态
    var vibrationState:Bool! = true
    //声音状态
    var voiceState:Bool! = true
    //正在聊天的对象conversationId
    var conversationId:String? = nil
    
    internal static let instance = PromptManager()
    
    private override init(){
    
    }
    
    func play(message:EMMessage){
        if voiceState! && self.conversationId != message.conversationId{
            AudioServicesPlaySystemSound(1007)
        }
        if vibrationState! && self.conversationId != message.conversationId{
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
        addNotification(message)
    }
    func addNotification(message:EMMessage) {
        let con = EMClient.sharedClient().chatManager.getConversation(message.conversationId, type: EMConversationTypeChat, createIfNotExist: true)
        con.isNotice()
        let localNoti = UILocalNotification()
        let fireDate = NSDate().dateByAddingTimeInterval(-15*60)
        localNoti.fireDate = fireDate
        localNoti.timeZone = NSTimeZone.defaultTimeZone()
        localNoti.alertBody = "\(con.nickname):\(message.showText)"
        localNoti.soundName = UILocalNotificationDefaultSoundName
        localNoti.alertAction = "打开应用"
        if let ext = message.ext{
            localNoti.userInfo = ext
        }
        UIApplication.sharedApplication().scheduleLocalNotification(localNoti)
    }

}
