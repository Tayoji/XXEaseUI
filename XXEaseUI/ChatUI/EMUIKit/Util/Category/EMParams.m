//
//  EMParams.m
//  supplier
//
//  Created by xiucheren on 16/8/1.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import "EMParams.h"

@implementation EMParams
-(instancetype)initWithDict:(NSDictionary *)ext{
    self = [super init];
    if (ext){
        [self setValuesForKeysWithDictionary:ext];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(id)valueForUndefinedKey:(NSString *)key{
    return  nil;
}
@end
