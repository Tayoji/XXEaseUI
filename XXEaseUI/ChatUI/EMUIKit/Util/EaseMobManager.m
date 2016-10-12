//
//  EaseMobManager.m
//  XXEaseUI
//
//  Created by xiucheren on 16/9/28.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import "EaseMobManager.h"
static EaseMobManager * share = nil;
@interface EaseMobManager()<EMChatManagerDelegate,EMClientDelegate>

@end
@implementation EaseMobManager
+(EaseMobManager *)share{
    if (!share) {
        @synchronized (self) {
            share = [[EaseMobManager alloc] init];
        }
    }
    return share;
}

- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    appkey:(NSString *)appkey
              apnsCertName:(NSString *)apnsCertName{
    [[EaseSDKHelper shareHelper] easemobApplication:application didFinishLaunchingWithOptions:launchOptions appkey:appkey apnsCertName:apnsCertName otherConfig:@{kSDKConfigEnableConsoleLogger:@NO}];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [[[EMClient sharedClient] chatManager] addDelegate:self delegateQueue:nil];
   
}
-(void)loginUsername:(NSString *)username CompletionBlock:(void (^)(EMError *))block{

    [[EMClient sharedClient] loginWithUsername:username password:username completion:^(NSString *aUsername, EMError *aError) {
        block(aError);
    }];
   
}
@end
