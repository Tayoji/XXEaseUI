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

@property (copy,   nonatomic) NSString * imUsername;
@property (copy,   nonatomic) NSString * imAvatarPath;
@property (copy,   nonatomic) NSString * imNickName;

@property (assign, nonatomic) NSInteger * unReadCount;
@property (strong,   nonatomic) UIImage * imAvatarImg;
@property (copy,nonatomic) void (^block)(NSInteger count);
+(EaseMobManager *)share;


- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    appkey:(NSString *)appkey
              apnsCertName:(NSString *)apnsCertName;

- (void)loginUsername:(NSString *)username CompletionBlock:(void (^)(EMError *aError))block;

- (void)logoutCompletionBlock:(void (^)(EMError *aError))block;

- (void)test:(void (^)(NSInteger count))block;


- (void)addObserver:(NSObject *)observer withConIds:(NSArray *)conIds notiBlock:(void (^)(NSArray * messages))block;

- (void)removeNotiObserver:(NSObject *)observer;
@end
