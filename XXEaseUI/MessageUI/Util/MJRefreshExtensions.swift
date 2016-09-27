//
//  MJRefreshExtensions.swift
//  supplier
//
//  Created by xiucheren on 16/7/25.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

import Foundation
import UIKit
#if !MJ_NO_MODULE
import MJRefresh
#endif
extension MJRefreshFooter{
    /**
     
     - parameter message:   提示消息
     - parameter clickable: 是可以下拉 或者 点击
     */
    func endRefreshing(_ message:String?,clickable:Bool?) {
        if clickable == nil || !(clickable!){
            endRefreshingWithNoMoreData()
        }else{
            endRefreshing()
        }
        isHidden = false
        
        for view in subviews{
            if view is UILabel{
                let label = view as! UILabel
                label.text = message
            }
        }
    }
}
extension UIScrollView{
    func addRefreshFooter(_ refreshingBlock:@escaping () -> Void) {
        
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: refreshingBlock)
        self.mj_footer = footer
    }
    
    func addRefreshHeader(_ refreshingBlock:@escaping () -> Void) {
        let header = MJRefreshNormalHeader(refreshingBlock: refreshingBlock)
        self.mj_header = header
    }
}
