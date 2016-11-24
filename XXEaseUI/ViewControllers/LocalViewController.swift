//
//  LocalViewController.swift
//  XXEaseUI
//
//  Created by xiucheren on 16/10/11.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

import UIKit

class LocalViewController: ViewController,UITableViewDelegate,UITableViewDataSource {
    var conIds = ["8aec5129e1627c00d0e5c0bb1eeb439d"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EaseMessageViewController(conversationChatter: "8aec5129e1627c00d0e5c0bb1eeb439d", nickname: "消息", avatar: "cuxiao_icon", ownNickname: "测试", ownAvatar: "")
        vc?.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc!, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
