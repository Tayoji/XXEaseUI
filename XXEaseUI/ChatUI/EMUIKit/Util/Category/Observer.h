//
//  Observer.h
//  XXEaseUI
//
//  Created by xiucheren on 16/10/13.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Observer : NSObject
@property (copy,nonatomic)NSString * key;
@property (assign,nonatomic)void (^block)(NSArray * messages);
@property (copy,nonatomic)NSArray * conIds;
@end
