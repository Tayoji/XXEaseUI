//
//  EMConversation+Noti.h
//  supplier
//
//  Created by xiucheren on 16/7/15.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import "EMConversation.h"
#import <objc/runtime.h>
#import "EMTextMessageBody.h"

@interface EMConversation (Noti)
@property (nonatomic,copy) NSString * nickname;
@property (nonatomic,copy) NSString * avatar;
@property (nonatomic,copy,readonly) NSString * lastMessageText;
+(EMConversation *)fetchWithConversationId:(NSString *)conversationId nickname:(NSString *)nickname avatar:(NSString *)avatar;
-(BOOL)isNotice;
-(NSString *)dateString;
+(void)saveConversationWithConversationId:(NSString *)conversationId nickname:(NSString *)nickname avatar:(NSString *)avatar;
@end
