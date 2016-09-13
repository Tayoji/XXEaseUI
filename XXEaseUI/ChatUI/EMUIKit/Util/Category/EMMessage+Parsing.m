//
//  EMMessage+Parsing.m
//  supplier
//
//  Created by xiucheren on 16/8/1.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import "EMMessage+Parsing.h"
#import <objc/runtime.h>
#import "IMessageModel.h"
@implementation EMMessage (Parsing)
-(void)setShowText:(NSString *)showText{
    objc_setAssociatedObject(self, "showText", showText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)showText{
    NSString * text = (NSString *)objc_getAssociatedObject(self, "showText");
    if (!text){
        text = @"";
        switch (self.body.type) {
            case EMMessageBodyTypeText:
                text = [(EMTextMessageBody *)self.body text];
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
        [self setShowText:text];

    }
    return text;
}
-(void)setEmExt:(EMExt *)emExt{
    objc_setAssociatedObject(self, "emExt", emExt, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(EMExt *)emExt{
    EMExt * em = (EMExt *)objc_getAssociatedObject(self, "emExt");
    if (!em){
        em = [[EMExt alloc] initWithDict:self.ext];
        [self setEmExt:em];
    }
    return em;
}
@end
