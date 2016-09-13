//
//  EMParams.h
//  supplier
//
//  Created by xiucheren on 16/8/1.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMParams : NSObject
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * enquiryItemId;
@property (nonatomic,copy) NSString * coverImage;
-(instancetype)initWithDict:(NSDictionary *)ext;
@end
