//
//  LoginViewController.swift
//  XXEaseUI
//
//  Created by xiucheren on 16/10/10.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

import UIKit

class LoginViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        MBProgressHUD.showAdded(to: view, animated: true)
        EaseMobManager.share().loginUsername((cell.contentView.viewWithTag(11) as! UILabel).text) {[unowned self , unowned cell] (error) in
            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            guard let _ = error else{
                self.performSegue(withIdentifier: "tabbar", sender: (cell.contentView.viewWithTag(11) as! UILabel).text)
                return
            }
            
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
   

}
