//
//  LoginViewController.swift
//  XXEaseUI
//
//  Created by xiucheren on 16/10/10.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

import UIKit

class LoginViewController: UITableViewController {
    var conIds = ["8aec5129e1627c00d0e5c0bb1eeb439d"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "tabbar", sender: (cell?.contentView.viewWithTag(11) as! UILabel).text)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
   

}
