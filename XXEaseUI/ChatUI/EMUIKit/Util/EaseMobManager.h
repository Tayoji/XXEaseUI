//
//  EaseMobManager.h
//  XXEaseUI
//
//  Created by xiucheren on 16/9/28.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EaseSDKHelper.h"
@interface EaseMobManager : NSObject

@property (copy,nonatomic) NSString * imUsername;
@property (assign,nonatomic) NSInteger * unreadCount;

+(EaseMobManager *)share;


- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    appkey:(NSString *)appkey
              apnsCertName:(NSString *)apnsCertName;

-(void)loginUsername:(NSString *)username CompletionBlock:(void (^)(EMError *aError))block;

@end
