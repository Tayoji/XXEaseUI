//
//  EMConversation+Noti.m
//  supplier
//
//  Created by xiucheren on 16/7/15.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import "EMConversation+Noti.h"
#import "IMessageModel.h"
#import "NSDate+Category.h"
#define ConversationInfo @"Conversation_Info"
@implementation EMConversation (Noti)
+(EMConversation *)fetchWithConversationId:(NSString *)conversationId nickname:(NSString *)nickname avatar:(NSString *)avatar{
    EMConversation * con = [[EMClient sharedClient].chatManager getConversation:conversationId type:EMConversationTypeChat createIfNotExist:YES];
    con.nickname = nickname;
    con.avatar = avatar;
    return con;
}
-(void)setAvatar:(NSString *)avatar{
    objc_setAssociatedObject(self, "avatar", avatar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)avatar{
    return  (NSString *)objc_getAssociatedObject(self, "avatar");
}
-(void)setNickname:(NSString *)nickname{
    objc_setAssociatedObject(self, "nickname", nickname, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
-(NSString *)nickname{
    
    return  (NSString *)objc_getAssociatedObject(self, "nickname");
}

-(NSString *)lastMessageText{
    EMMessageBody * body = (EMMessageBody *)[self valueForKeyPath:@"latestMessage.body"];

    NSString * text = @"";
    switch (body.type) {
        case EMMessageBodyTypeText:
            text = [(EMTextMessageBody *)body text];
            break;
           case EMMessageBodyTypeImage:
            text = @"[图片]";
            break;
        case EMMessageBodyTypeVideo:
            text = @"[视频]";
            break;
        case EMMessageBodyTypeVoice:
            text = @"[语音]";
            break;
        default:
            break;
    }
    return text;
}
-(BOOL)isNotice{
    if ([self.conversationId isEqualToString:@"system"]) {
        self.nickname = @"系统消息";
        self.avatar = @"xitongxiaoxi_icon";
        return YES;
    } else if([self.conversationId isEqualToString:@"product"]) {
        self.nickname = @"产品消息";
        self.avatar = @"chanpinxiaoxi_icon";

        return YES;
 
    }else if([self.conversationId isEqualToString:@"purchaseorder"]) {
        self.nickname = @"订单消息";
        self.avatar = @"caigoudingdanxiaoxi_icon";
        return YES;
        
    }else if([self.conversationId isEqualToString:@"saleorder"]) {
        self.nickname = @"销售订单消息";
        self.avatar = @"caigoudingdanxiaoxi_icon";
        return YES;
        
    }else if([self.conversationId isEqualToString:@"logistics"]) {
        self.nickname = @"物流消息";
        self.avatar = @"wuliuxiaoxi_icon";
        return YES;
        
    }else if([self.conversationId isEqualToString:@"aftersale"]) {
        self.nickname = @"售后消息";
        self.avatar = @"shouhouxiaoxi_icon";
        return YES;
        
    }else if([self.conversationId isEqualToString:@"promotion"]) {
        self.nickname = @"促销消息";
        self.avatar = @"cuxiaoxiaoxi_icon";
        return YES;
        
    }else if([self.conversationId isEqualToString:@"notice"]) {
        self.nickname = @"公告消息";
        self.avatar = @"gonggaoxiaoxi_icon";
        return YES;
        
    }else if([self.conversationId isEqualToString:@"finance"]) {
        self.nickname = @"财务消息";
        self.avatar = @"caiwuxiaoxi_icon";
        return YES;
        
    }else if([self.conversationId isEqualToString:@"wenda"]) {
        self.nickname = @"问答消息";
        self.avatar = @"wendaxiaoxi_icon";
        return YES;
    }else if([self.conversationId isEqualToString:@"supplieritemstockalarm"]) {
        self.nickname = @"系统消息";
        self.avatar = @"xt_icon";
        return YES;
    }else if([self.conversationId isEqualToString:@"enquiry"]) {
        self.nickname = @"询货消息";
        self.avatar = @"xunhuoxiaoxi_icon";
        return YES;
        
    }else if([self.conversationId isEqualToString:@"bulkorder"]) {
        self.nickname = @"批采消息";
        self.avatar = @"picaixiaoxi_icon";
        return YES;
        
    }else{
        
        NSString * name = (NSString *)[self valueForKeyPath:[NSString stringWithFormat:@"latestMessageFromOthers.%@",USER_NickName]];
        NSString * avatarpath = (NSString *)[self valueForKeyPath:[NSString stringWithFormat:@"latestMessageFromOthers.%@",USER_Avatar]];
        
        if (!name || name.length <= 0){
          NSArray * dataArr = [[NSUserDefaults standardUserDefaults] arrayForKey:ConversationInfo];
            if (dataArr){
                for (NSDictionary *dict in dataArr) {
                    if ([dict[@"conversationId"] isEqualToString:self.conversationId]){
                        name = dict[@"nickname"];
                        avatarpath = dict[@"avatar"];
                        break;
                    }
                }
            }
        }
        
        self.nickname = name != nil && name.length > 0 ? name : @"消息";
        self.avatar = avatarpath != nil && avatarpath.length > 0  ? avatarpath : @"EaseUIResource.bundle/user";
        return NO;
    }
}
-(NSString *)dateString{
    long long dateNum = self.latestMessage.timestamp;
    return dateNum ? [NSDate formattedTimeFromTimeInterval:dateNum] : @"";
}

+(void)saveConversationWithConversationId:(NSString *)conversationId nickname:(NSString *)nickname avatar:(NSString *)avatar{
  NSArray * dataArr = [[NSUserDefaults standardUserDefaults] arrayForKey:ConversationInfo];
    if (dataArr){
        
        NSMutableArray * newArr = [NSMutableArray arrayWithArray: [dataArr filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return ![evaluatedObject[@"conversationId"] isEqualToString:conversationId];
        }]]];
        [newArr addObject:@{@"conversationId":conversationId,@"nickname":(nickname) ? nickname : @"",@"avatar":(avatar) ? avatar : @""}];
        [[NSUserDefaults standardUserDefaults] setObject:newArr forKey:ConversationInfo];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@[@{@"conversationId":conversationId,@"nickname":(nickname) ? nickname : @"",@"avatar":(avatar) ? avatar : @""}] forKey:ConversationInfo];
    }

}

@end
