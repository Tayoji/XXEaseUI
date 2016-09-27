//
//  EaseMessageController.swift
//  supplier
//
//  Created by xiucheren on 16/7/25.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

import UIKit

class EaseMessageController: UIViewController {
    var seg:UISegmentedControl!
    var notiCountView:UIView!
    var sessionCountView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        creatSeg()
        addchildVc()
        // Do any additional setup after loading the view.
    }
    func creatSeg(){
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: 128, height: 29))
        seg = UISegmentedControl.init(frame: backView.bounds)
        seg.insertSegment(withTitle: "通知", at: 0, animated: true)
        seg.insertSegment(withTitle: "会话", at: 1, animated: true)
        seg.selectedSegmentIndex = 0
        seg.tintColor = UIColor.white
        backView.addSubview(seg)
        self.navigationItem.titleView = backView
        seg.addTarget(self, action: #selector(EaseMessageController.selectSeg(_:)), for: UIControlEvents.valueChanged)
        notiCountView = UIView(frame: CGRect(x: 45, y: 5, width: 8, height: 8))
        notiCountView.backgroundColor = UIColor.red
        notiCountView.layer.cornerRadius = 4
        backView.addSubview(notiCountView)
        
        sessionCountView = UIView(frame: CGRect(x: 45 + 64, y: 5, width: 8, height: 8))
        sessionCountView.backgroundColor = UIColor.red
        sessionCountView.layer.cornerRadius = 4
        backView.addSubview(notiCountView)
    }
    func selectSeg(_ seg:UISegmentedControl){
        for tag in 5001...5002{
            let childView = view.viewWithTag(tag)
            childView?.isHidden = tag != 5001 + seg.selectedSegmentIndex
//            MobClick.event(tag == 5001 ? message_list_notice : message_list_session)

        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        MobClick.event(seg.selectedSegmentIndex == 0 ? message_list_notice : message_list_session)

    }
    func addchildVc(){
        for index in 0...1{
            let vc = EaseChatListController()
            vc.changeMessageCountBlock = {(count) in
                switch index {
                case 0:
                    self.notiCountView.isHidden = count == 0
                    break
                case 1:
                    self.sessionCountView.isHidden = count == 0
                    break
                default:
                    break
                }
            }
            vc.isNotices = index == 0
            vc.view.tag = 5001 + index
            vc.view.isHidden = index != 0
            addChildViewController(vc)
            view.addSubview(vc.view)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
