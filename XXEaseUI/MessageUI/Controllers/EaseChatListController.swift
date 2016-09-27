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
    var changeMessageCountBlock:((_ count:Int32) ->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame:CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 64), style: UITableViewStyle.plain)
         tableView.register(UINib.init(nibName: "ChatListCell", bundle: nil), forCellReuseIdentifier: "ChatListCell")
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
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(EaseChatListController.refreshAndSort), name: NSNotification.Name(rawValue: UpdateMessage), object: nil)
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshAndSort()
    }
    func refreshAndSort(){
        var count:Int32 = 0
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: { [unowned self] in
            self.conversations =  (EMClient.shared().chatManager.getAllConversations() as! [EMConversation]).filter({ (con) -> Bool in
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
            }).sorted(by: { (con1, con2) -> Bool in
                return con1.latestMessage.timestamp > con2.latestMessage.timestamp
                
            })
            DispatchQueue.main.async(execute: {
                self.tableView.mj_header.endRefreshing()
                self.conversations.count == 0 ? self.tableView.mj_footer.endRefreshing("您暂时没有消息", clickable: nil) : self.tableView.mj_footer.endRefreshingWithNoMoreData()
                self.tableView.reloadData()
                if self.changeMessageCountBlock != nil {
                    self.changeMessageCountBlock!(count)
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath) as!  ChatListCell
        cell.showData(conversations[(indexPath as NSIndexPath).row])
        return cell
    }
    @objc(tableView:editingStyleForRowAtIndexPath:) func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
           // EMClient.sharedClient().chatManager.deleteConversation(conversations[indexPath.row].conversationId, deleteMessages: true)
             EMClient.shared().chatManager.deleteConversation(conversations[(indexPath as NSIndexPath).row].conversationId, isDeleteMessages: true, completion: { (str, error) in
                
             })
            conversations.remove(at: (indexPath as NSIndexPath).row)
            tableView.reloadData()
        }
    }
    
}
