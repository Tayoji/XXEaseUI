/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import <Foundation/Foundation.h>

#import "EaseConversationListViewController.h"
#import "EaseMessageViewController.h"
#import "EaseUsersListViewController.h"
#import "EaseViewController.h"

#import "IModelCell.h"
#import "IModelChatCell.h"
#import "EaseMessageCell.h"
#import "EaseBaseMessageCell.h"
#import "EaseBubbleView.h"
#import "EaseUserCell.h"


#import "EaseChineseToPinyin.h"
#import "EaseEmoji.h"
#import "EaseEmotionEscape.h"
#import "EaseEmotionManager.h"
#import "EaseSDKHelper.h"
#import "EMCDDeviceManager.h"
#import "EaseConvertToCommonEmoticonsHelper.h"

#import "NSDate+Category.h"
#import "NSString+Valid.h"
#import "UIImageView+EMWebCache.h"
#import "UIViewController+HUD.h"
#import "UIViewController+DismissKeyboard.h"
#import "EaseLocalDefine.h"
#import "EMConversation+Noti.h"
#import "EMMessage+Parsing.h"
#define RGBA(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#define BlackColor RGBA(53, 53, 53)
#define BackgrounpColor RGBA(240, 240, 240)
#define RedColor RGBA(234, 41, 41) 
#define GrayColor RGBA(153, 153, 153) 
@interface EaseUI : NSObject

@end
