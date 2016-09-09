//
//  MoreMenuView.swift
//  supplier
//
//  Created by xiucheren on 16/7/28.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

import UIKit
let MoreMenuViewTag = 5214
class MoreMenuView: UIView {
    var backImageView:UIImageView!
    let itemTag = 1001
    var selectIndexBlock:((index:Int) -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createView()
    }
    func createView(){
       
        self.backImageView = UIImageView(frame:  CGRect(x: self.bounds.size.width - 120 - 15, y: -96, width: 120, height: 96))
        self.backImageView.image = UIImage(named: "EaseUIResource.bundle/moreMenu/xiala_bj")?.stretchableImageWithLeftCapWidth(10, topCapHeight: 10)
        self.backImageView.userInteractionEnabled = true
        self.addSubview(self.backImageView)
        
        for (index,ImgName) in ["EaseUIResource.bundle/moreMenu/home","EaseUIResource.bundle/moreMenu/message"].enumerate(){
            let view = UIButton.init(frame: CGRect(x: 0, y: 8 + 44 * CGFloat(index), width: self.backImageView.bounds.size.width, height: 44))
            view.backgroundColor = UIColor.clearColor()
            let img = UIImageView(frame: CGRect(x: 15, y: (44 - 18)/2.0, width: 18, height: 18))
            img.image = UIImage(named: ImgName)
            view.addSubview(img)
            view.tag = itemTag + index
            let label = UILabel(frame: CGRect(x: CGRectGetMaxX(img.frame) + 8, y: (44 - 18)/2.0, width: 40, height: 18))
            label.textColor = UIColor.whiteColor()
            label.text = index == 0 ? "首页" : "消息"
            label.font = UIFont.systemFontOfSize(14)
            view.addSubview(label)
            view.addTarget(self, action: #selector(MoreMenuView.clickButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.backImageView.addSubview(view)
            if index == 1{
                let alertView = UIView.init(frame: CGRect(x: 100, y: 16, width: 8, height: 8))
                alertView.backgroundColor = UIColor.redColor()
                alertView.layer.masksToBounds = true
                alertView.layer.cornerRadius = 4
                view.addSubview(alertView)
                alertView.hidden = EaseMobManager.instance.unreadMessageCount() == 0
            }
        }
    }
    func clickButton(button:UIButton){
        if selectIndexBlock != nil {
            selectIndexBlock!(index:button.tag - itemTag)
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if selectIndexBlock != nil {
            selectIndexBlock!(index:-1)
        }

    }
    
    class func showMoreMenuView(showView:UIView,block:((index:Int) -> Void)? = nil) ->MoreMenuView{
        let menuView = MoreMenuView.init(frame: showView.bounds)
        showView.addSubview(menuView)
        menuView.selectIndexBlock = block
        menuView.tag = MoreMenuViewTag
        var frame = menuView.backImageView.frame
        frame.origin.y = 5
        UIView.animateWithDuration(0.5, animations: {
            
            menuView.backImageView.frame = frame
        })
        return menuView
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
