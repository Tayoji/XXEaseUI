//
//  EaseMobManager.m
//  XXEaseUI
//
//  Created by xiucheren on 16/9/28.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import "EaseMobManager.h"
#import "Observer.h"
static EaseMobManager * share = nil;
@interface EaseMobManager()<EMChatManagerDelegate,EMClientDelegate>
@property (strong,nonatomic) NSMutableArray * messageObservers;
@end
@implementation EaseMobManager
+(EaseMobManager *)share{
    if (!share) {
        @synchronized (self) {
            share = [[EaseMobManager alloc] init];
            share.imAvatarImg = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
            share.unReadCount = 0;
            share.messageObservers = [[NSMutableArray alloc] init];
            
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
-(void)logoutCompletionBlock:(void (^)(EMError *))block{
    
    [[EMClient sharedClient] logout:YES completion:^(EMError *aError) {
        block(aError);
    }];
}
-(void)didReceiveMessages:(NSArray *)aMessages{
    self.unReadCount += 1;
    
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t que = dispatch_queue_create("com.noti.message", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(que, ^{
        for (EMMessage * message in aMessages) {
            for (Observer * ob in weakSelf.messageObservers) {
                NSLog(@"%@",ob.conIds);
                if ([ob.conIds containsObject:message.conversationId]){
                    __weak typeof(ob) weakOb = ob;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @synchronized (weakSelf) {
                            if (weakOb && weakOb.block){
                                weakOb.block(aMessages);
                            }
                        }
                    });
                }
            }
        }
    });
    
}

-(void)addObserver:(NSObject *)observer withConIds:(NSArray *)conIds notiBlock:(void (^)(NSArray *))block{
    
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t que = dispatch_queue_create("com.noti.message", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(que, ^{
        
        NSString * observerClassName = NSStringFromClass(observer.class);
        [weakSelf.messageObservers filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return ![observerClassName isEqualToString:NSStringFromClass([evaluatedObject class])];
        }]];
        Observer * ob = [[Observer alloc] init];
        ob.key = observerClassName;
        ob.block = block;
        ob.conIds = conIds;
        
        [weakSelf.messageObservers addObject:ob];
       
    });
   
}

-(void)removeNotiObserver:(NSObject *)observer{
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t que = dispatch_queue_create("com.noti.message", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(que, ^{
        NSString * observerClassName = NSStringFromClass(observer.class);
        [weakSelf.messageObservers filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return ![observerClassName isEqualToString:NSStringFromClass([evaluatedObject class])];
        }]];
    });
    
   

}
@end
