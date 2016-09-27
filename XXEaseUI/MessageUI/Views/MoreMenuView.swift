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
    var selectIndexBlock:((_ index:Int) -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createView()
    }
    func createView(){
       
        self.backImageView = UIImageView(frame:  CGRect(x: self.bounds.size.width - 120 - 15, y: -96, width: 120, height: 96))
        self.backImageView.image = UIImage(named: "EaseUIResource.bundle/moreMenu/xiala_bj")?.stretchableImage(withLeftCapWidth: 10, topCapHeight: 10)
        self.backImageView.isUserInteractionEnabled = true
        self.addSubview(self.backImageView)
        
        for (index,ImgName) in ["EaseUIResource.bundle/moreMenu/home","EaseUIResource.bundle/moreMenu/message"].enumerated(){
            let view = UIButton.init(frame: CGRect(x: 0, y: 8 + 44 * CGFloat(index), width: self.backImageView.bounds.size.width, height: 44))
            view.backgroundColor = UIColor.clear
            let img = UIImageView(frame: CGRect(x: 15, y: (44 - 18)/2.0, width: 18, height: 18))
            img.image = UIImage(named: ImgName)
            view.addSubview(img)
            view.tag = itemTag + index
            let label = UILabel(frame: CGRect(x: img.frame.maxX + 8, y: (44 - 18)/2.0, width: 40, height: 18))
            label.textColor = UIColor.white
            label.text = index == 0 ? "首页" : "消息"
            label.font = UIFont.systemFont(ofSize: 14)
            view.addSubview(label)
            view.addTarget(self, action: #selector(MoreMenuView.clickButton(_:)), for: UIControlEvents.touchUpInside)
            self.backImageView.addSubview(view)
            if index == 1{
                let alertView = UIView.init(frame: CGRect(x: 100, y: 16, width: 8, height: 8))
                alertView.backgroundColor = UIColor.red
                alertView.layer.masksToBounds = true
                alertView.layer.cornerRadius = 4
                view.addSubview(alertView)
                alertView.isHidden = EaseMobManager.instance.unreadMessageCount() == 0
            }
        }
    }
    func clickButton(_ button:UIButton){
        if selectIndexBlock != nil {
            selectIndexBlock!(button.tag - itemTag)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if selectIndexBlock != nil {
            selectIndexBlock!(-1)
        }

    }
    
    class func showMoreMenuView(_ showView:UIView,block:((_ index:Int) -> Void)? = nil) ->MoreMenuView{
        let menuView = MoreMenuView.init(frame: showView.bounds)
        showView.addSubview(menuView)
        menuView.selectIndexBlock = block
        menuView.tag = MoreMenuViewTag
        var frame = menuView.backImageView.frame
        frame.origin.y = 5
        UIView.animate(withDuration: 0.5, animations: {
            
            menuView.backImageView.frame = frame
        })
        return menuView
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
