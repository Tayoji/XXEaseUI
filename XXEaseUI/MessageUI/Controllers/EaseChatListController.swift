//
//  EaseChatListController.swift
//  supplier
//
//  Created by xiucheren on 16/7/25.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

import UIKit

class EaseChatListController: UIViewController {
    var conversations = [EMConversation]()
    var isNotices = true
    var tableView : UITableView!
    var changeMessageCountBlock:((count:Int32) ->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64), style: UITableViewStyle.Plain)
         tableView.registerNib(UINib.init(nibName: "ChatListCell", bundle: nil), forCellReuseIdentifier: "ChatListCell")
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.backgroundColor = UIColor.backgroundColor()
        view.addSubview(tableView)
       
        tableView.addRefreshFooter { [unowned self] in
            self.refreshAndSort()
        }
        tableView.addRefreshHeader { [unowned self] in
            self.refreshAndSort()
        }
        tableView.tableFooterView = UIView()
        tableView.mj_header.beginRefreshing()
        NSNotificationCenter.defaultCenter().removeObserver(self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EaseChatListController.refreshAndSort), name: UpdateMessage, object: nil)
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshAndSort()
    }
    func refreshAndSort(){
        var count:Int32 = 0
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { [unowned self] in
            self.conversations =  (EMClient.sharedClient().chatManager.getAllConversations() as! [EMConversation]).filter({ (con) -> Bool in
                if let  _ = con.latestMessage {
                    if con.isNotice() == self.isNotices {
                        count += con.unreadMessagesCount
                        return true
                    }else{
                        return false
                    }
//                    return con.isNotice() == self.isNotices
                }
                return false
            }).sort({ (con1, con2) -> Bool in
                return con1.latestMessage.timestamp > con2.latestMessage.timestamp
                
            })
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.mj_header.endRefreshing()
                self.conversations.count == 0 ? self.tableView.mj_footer.endRefreshing("您暂时没有消息", clickable: nil) : self.tableView.mj_footer.endRefreshingWithNoMoreData()
                self.tableView.reloadData()
                if self.changeMessageCountBlock != nil {
                    self.changeMessageCountBlock!(count: count)
                }
            })
            })
        
    }
  
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension EaseChatListController:UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatListCell", forIndexPath: indexPath) as!  ChatListCell
        cell.showData(conversations[indexPath.row])
        return cell
    }
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
           // EMClient.sharedClient().chatManager.deleteConversation(conversations[indexPath.row].conversationId, deleteMessages: true)
             EMClient.sharedClient().chatManager.deleteConversation(conversations[indexPath.row].conversationId, isDeleteMessages: true, completion: { (str, error) in
                
             })
            conversations.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
}
