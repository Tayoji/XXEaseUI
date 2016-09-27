//
//  EaseChatDetailsController.swift
//  supplier
//
//  Created by xiucheren on 16/7/28.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

import UIKit

class EaseChatDetailsController: EaseMessageViewController {
    var moreMenuView:MoreMenuView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.post(name: Notification.Name(rawValue: UpdateMessageCount), object: nil)
        self.configurationView()
        hasNewMessages = EaseMobManager.instance.unreadMessageCount() > 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

