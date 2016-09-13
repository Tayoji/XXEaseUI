//
//  EMExt.h
//  supplier
//
//  Created by xiucheren on 16/8/1.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMParams.h"
@interface EMExt : NSObject
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * actionType;
@property (nonatomic,copy) NSString * actionUrl;
@property (nonatomic,copy) NSString * businessType;
@property (nonatomic,copy) EMParams * params;

-(instancetype)initWithDict:(NSDictionary *)ext;
@end
