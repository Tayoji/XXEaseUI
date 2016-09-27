//
//  ChatListCell.swift
//  supplier
//
//  Created by xiucheren on 16/7/25.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

import UIKit

class ChatListCell: UITableViewCell {

    @IBOutlet weak var countWidth: NSLayoutConstraint!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var avatarImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImg.layer.masksToBounds = true
        avatarImg.layer.cornerRadius = 5
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        // Initialization code
    }
    func showData(_ model:EMConversation){
        infoLabel.text = model.lastMessageText
        titleLabel.text = model.nickname
        dateLabel.text = model.dateString()
        countLabel.isHidden = model.unreadMessagesCount == 0
        
        countLabel.text = "\(model.unreadMessagesCount)"
        if model.unreadMessagesCount > 9 {
            let width = (countLabel.text! as NSString).boundingRect(with: CGSize(width: 50, height: 15), options: NSStringDrawingOptions.usesFontLeading, attributes: [NSFontAttributeName:countLabel.font], context: nil).size.width
            countWidth.constant = 10 + width
        }else{
            countWidth.constant = 15
        }
        
        if model.avatar.hasPrefix("http"){
            avatarImg.sd_setImage(with: URL.init(string: model.avatar)!, placeholderImage: UIImage.init(named: "EaseUIResource.bundle/user"))
        }else{
            avatarImg.image = UIImage(named: model.avatar)
            
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
