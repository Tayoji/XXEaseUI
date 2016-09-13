//
//  ChatTableViewHeader.h
//  supplier
//
//  Created by xiucheren on 16/7/12.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseUI.h"
typedef void(^SendBlock)(NSObject * value);
@interface ChatTableViewHeader : UIView
+(ChatTableViewHeader *)configurationWithGoods:(NSObject *)goods customerService:(NSObject *)customerService block:(SendBlock)block;
@end
